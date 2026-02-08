import "sort"

func maxNumberOfFamilies(n int, reservedSeats [][]int) int {
	seats := make(map[int][]int)
	for _, seat := range reservedSeats {
		seats[seat[0]] = append(seats[seat[0]], seat[1])
	}

	count := 2 * n
	for _, reserved := range seats {
		sort.Ints(reserved)
		possible := 0
		if !contains(reserved, 2) && !contains(reserved, 3) && !contains(reserved, 4) && !contains(reserved, 5) {
			possible++
		}
		if !contains(reserved, 6) && !contains(reserved, 7) && !contains(reserved, 8) && !contains(reserved, 9) {
			possible++
		}
		if !contains(reserved, 4) && !contains(reserved, 5) && !contains(reserved, 6) && !contains(reserved, 7) {
			possible = max(possible, 1)
		}

		count -= (2 - possible)
	}

	return count
}

func contains(arr []int, target int) bool {
	for _, num := range arr {
		if num == target {
			return true
		}
	}
	return false
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}