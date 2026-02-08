package main

import (
	"sort"
	"strings"
)

func shortestUncommonSubstrings(arr []string) []string {
	n := len(arr)
	ans := make([]string, n)

	for i := 0; i < n; i++ {
		currentStr := arr[i]
		minUncommonSub := ""

		for length := 1; length <= len(currentStr); length++ {
			currentLengthSubstrings := []string{}
			for start := 0; start <= len(currentStr)-length; start++ {
				sub := currentStr[start : start+length]
				currentLengthSubstrings = append(currentLengthSubstrings, sub)
			}

			sort.Strings(currentLengthSubstrings)

			foundUncommonOfThisLength := false
			for _, sub := range currentLengthSubstrings {
				isUncommon := true
				for j := 0; j < n; j++ {
					if i == j {
						continue
					}
					if strings.Contains(arr[j], sub) {
						isUncommon = false
						break
					}
				}

				if isUncommon {
					minUncommonSub = sub
					foundUncommonOfThisLength = true
					break
				}
			}
			if foundUncommonOfThisLength {
				break
			}
		}
		ans[i] = minUncommonSub
	}
	return ans
}