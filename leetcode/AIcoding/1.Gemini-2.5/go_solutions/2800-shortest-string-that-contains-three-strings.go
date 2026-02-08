package main

import (
	"strings"
)

func shortestStringThatContainsThreeStrings(s1 string, s2 string, s3 string) string {
	merge := func(a, b string) string {
		if strings.Contains(a, b) {
			return a
		}
		if strings.Contains(b, a) {
			return b
		}

		getOverlapString := func(s_a, s_b string) string {
			maxOverlapLen := 0
			for i := 1; i <= len(s_a) && i <= len(s_b); i++ {
				if s_a[len(s_a)-i:] == s_b[:i] {
					maxOverlapLen = i
				}
			}
			return s_a + s_b[maxOverlapLen:]
		}

		candidate1 := getOverlapString(a, b)
		candidate2 := getOverlapString(b, a)

		if len(candidate1) < len(candidate2) {
			return candidate1
		} else if len(candidate1) > len(candidate2) {
			return candidate2
		} else {
			if candidate1 < candidate2 {
				return candidate1
			}
			return candidate2
		}
	}

	permutations := [][]string{
		{s1, s2, s3},
		{s1, s3, s2},
		{s2, s1, s3},
		{s2, s3, s1},
		{s3, s1, s2},
		{s3, s2, s1},
	}

	shortestOverall := ""

	for _, p := range permutations {
		mergedTwo := merge(p[0], p[1])
		finalString := merge(mergedTwo, p[2])

		if shortestOverall == "" || len(finalString) < len(shortestOverall) {
			shortestOverall = finalString
		} else if len(finalString) == len(shortestOverall) {
			if finalString < shortestOverall {
				shortestOverall = finalString
			}
		}
	}

	return shortestOverall
}