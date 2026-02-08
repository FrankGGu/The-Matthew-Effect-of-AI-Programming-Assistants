import "fmt"

func earliestAndLatest(n int, firstPlayer int, secondPlayer int) []int {
	minRound := n
	maxRound := 1
	var solve func(players []bool, round int)
	solve = func(players []bool, round int) {
		f := -1
		s := -1
		for i := 0; i < n; i++ {
			if players[i] {
				if i+1 == firstPlayer {
					f = i
				}
				if i+1 == secondPlayer {
					s = i
				}
			}
		}
		if f != -1 && s != -1 {
			if f > s {
				f, s = s, f
			}
			cnt := 0
			for i := 0; i < n; i++ {
				if players[i] {
					cnt++
				}
			}
			if (s-f == 1 && cnt == 2) || (n%2 == 1 && cnt == 2 && (f == n/2 || s == n/2)) {
				if round < minRound {
					minRound = round
				}
				if round > maxRound {
					maxRound = round
				}
				return
			}
		}

		nextPlayers := make([]bool, n)
		var generateNextRound func(i int, nextRoundPlayers []bool, count int)
		generateNextRound = func(i int, nextRoundPlayers []bool, count int) {
			if i >= n {
				if count == (n+1)/2 {
					solve(nextRoundPlayers, round+1)
				}
				return
			}
			if !players[i] {
				generateNextRound(i+1, nextRoundPlayers, count)
				return
			}

			if i+1 == firstPlayer || i+1 == secondPlayer {
				nextRoundPlayers[i/2] = true
				generateNextRound(i+2, nextRoundPlayers, count+1)
			} else {
				nextRoundPlayers[i/2] = true
				generateNextRound(i+2, nextRoundPlayers, count+1)
				temp := make([]bool, n)
				copy(temp, nextRoundPlayers)
				temp[i/2] = false
				generateNextRound(i+2, temp, count)
			}
		}
		generateNextRound(0, nextPlayers, 0)
	}

	players := make([]bool, n)
	for i := 0; i < n; i++ {
		players[i] = true
	}
	solve(players, 1)

	return []int{minRound, maxRound}
}