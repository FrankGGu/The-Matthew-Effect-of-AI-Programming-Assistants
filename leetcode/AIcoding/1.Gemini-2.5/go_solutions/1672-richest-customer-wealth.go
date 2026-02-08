package main

func maximumWealth(accounts [][]int) int {
	maxWealth := 0
	for i := 0; i < len(accounts); i++ {
		currentWealth := 0
		for j := 0; j < len(accounts[i]); j++ {
			currentWealth += accounts[i][j]
		}
		if currentWealth > maxWealth {
			maxWealth = currentWealth
		}
	}
	return maxWealth
}