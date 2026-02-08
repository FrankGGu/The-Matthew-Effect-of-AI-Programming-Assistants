package main

import (
	"fmt"
	"math"
	"strconv"
	"strings"
)

func minCostToSetCookingTime(targetSeconds int, startAt int, moveCost int, pushCost int) int {
	minCost := math.MaxInt32

	calculateCost := func(timeStr string) int {
		currentFingerPos := startAt
		cost := 0
		for _, r := range timeStr {
			digit := int(r - '0')
			if digit != currentFingerPos {
				cost += moveCost
			}
			cost += pushCost
			currentFingerPos = digit
		}
		return cost
	}

	formatTime := func(m, s int) string {
		s_m := strconv.Itoa(m)
		s_s := fmt.Sprintf("%02d", s)
		full_str := s_m + s_s
		final_str := strings.TrimLeft(full_str, "0")
		if final_str == "" {
			return "0"
		}
		return final_str
	}

	// Case 1: m1 minutes and s1 seconds
	// m1 = targetSeconds / 60, s1 = targetSeconds % 60
	m1 := targetSeconds / 60
	s1 := targetSeconds % 60

	if m1 <= 99 { // Minutes must be <= 99
		timeStr1 := formatTime(m1, s1)
		cost1 := calculateCost(timeStr1)
		if cost1 < minCost {
			minCost = cost1
		}
	}

	// Case 2: m2 minutes and s2 seconds (by "borrowing" 60 seconds from minutes)
	// m2 = m1 - 1, s2 = s1 + 60
	// This is valid if m1 > 0 (so m2 >= 0) and s1 + 60 <= 99 (so s2 <= 99)
	if m1 > 0 && s1+60 <= 99 {
		m2 := m1 - 1
		s2 := s1 + 60
		timeStr2 := formatTime(m2, s2)
		cost2 := calculateCost(timeStr2)
		if cost2 < minCost {
			minCost = cost2
		}
	}

	return minCost
}