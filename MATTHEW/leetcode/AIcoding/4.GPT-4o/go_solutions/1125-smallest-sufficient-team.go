package main

import "fmt"

func smallestSufficientTeam(reqSkills []string, people [][]string) []int {
	skillIndex := make(map[string]int)
	for i, skill := range reqSkills {
		skillIndex[skill] = i
	}

	n := len(reqSkills)
	p := len(people)
	dp := make([][]int, 1<<n)
	for i := range dp {
		dp[i] = make([]int, 0)
	}
	dp[0] = []int{}

	for i := 0; i < p; i++ {
		skillMask := 0
		for _, skill := range people[i] {
			if idx, ok := skillIndex[skill]; ok {
				skillMask |= 1 << idx
			}
		}
		for j := (1 << n) - 1; j >= 0; j-- {
			if dp[j] != nil {
				newMask := j | skillMask
				if len(dp[newMask]) == 0 || len(dp[newMask]) > len(dp[j])+1 {
					dp[newMask] = append([]int(nil), dp[j]...)
					dp[newMask] = append(dp[newMask], i)
				}
			}
		}
	}
	return dp[(1<<n)-1]
}

func main() {
	reqSkills := []string{"java", "nodejs", "reactjs"}
	people := [][]string{
		{"java"},
		{"nodejs"},
		{"nodejs", "reactjs"},
	}
	result := smallestSufficientTeam(reqSkills, people)
	fmt.Println(result)
}