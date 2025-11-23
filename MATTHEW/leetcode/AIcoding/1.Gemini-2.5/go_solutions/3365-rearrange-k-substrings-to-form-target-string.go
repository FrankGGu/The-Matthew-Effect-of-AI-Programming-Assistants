package main

import "math"

func rearrangeCharacters(s string, target string) int {
	sFreq := [26]int{}
	for _, r := range s {
		sFreq[r-'a']++
	}

	targetFreq := [26]int{}
	for _, r := range target {
		targetFreq[r-'a']++
	}

	ans := math.MaxInt32

	for i := 0; i < 26; i++ {
		if targetFreq[i] > 0 {
			possible := sFreq[i] / targetFreq[i]
			if possible < ans {
				ans = possible
			}
		}
	}

	return ans
}