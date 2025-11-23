package main

import (
	"sort"
)

type pair struct {
	sum   int64
	count int64
}

func calculateMaxScoreAndCount(distinctValues []int, valToCount map[int]int, lambda int64) pair {
	m := len(distinctValues)
	if m == 0 {
		return pair{0, 0}
	}

	// dpPrevPrev stores (sum, count) for distinctValues[i-2]
	// dpPrev stores (sum, count) for distinctValues[i-1]
	dpPrevPrev := pair{0, 0}
	dpPrev := pair{0, 0}

	for i, v := range distinctValues {
		c := int64(valToCount[v])

		// Option 1: Don't pick v
		s1, c1 := dpPrev.sum, dpPrev.count

		// Option 2: Pick v (all occurrences)
		var s2, c2 int64
		if i > 0 && distinctValues[i-1] == v-1 { // v is adjacent to v_prev
			// Cannot pick v_prev, so use state from dpPrevPrev
			s2, c2 = dpPrevPrev.sum+int64(v)*c, dpPrevPrev.count+c
		} else { // v is not adjacent to v_prev
			// Can use state from dpPrev
			s2, c2 = dpPrev.sum+int64(v)*c, dpPrev.count+c
		}

		score1 := s1 - lambda*c1
		score2 := s2 - lambda*c2

		var currentS, currentC int64
		if score2 > score1 {
			currentS, currentC = s2, c2
		} else if score1 > score2 {
			currentS, currentC = s1, c1
		} else { // Scores are equal, prefer smaller count
			if c2 < c1 {
				currentS, currentC = s2, c2
			} else {
				currentS, currentC = s1, c1
			}
		}

		dpPrevPrev = dpPrev
		dpPrev = pair{currentS, currentC}
	}

	return dpPrev
}

func challenge(nums []int, cnt int) int64 {
	valToCount := make(map[int]int)
	maxVal := 0
	for _, num := range nums {
		valToCount[num]++
		if num > maxVal {
			maxVal = num
		}
	}

	distinctValues := make([]int, 0, len(valToCount))
	for val := range valToCount {
		distinctValues = append(distinctValues, val)
	}
	sort.Ints(distinctValues)

	// Binary search for lambda
	low := int64(0)
	high := int64(maxVal + 1) // Lambda can be up to max_val. Add 1 for safety.

	var ansS, ansC int64
	var ansLambda int64

	for low <= high {
		midLambda := low + (high-low)/2
		currentPair := calculateMaxScoreAndCount(distinctValues, valToCount, midLambda)
		currentS, currentC := currentPair.sum, currentPair.count

		if currentC >= int64(cnt) {
			// This lambda gives enough or too many items.
			// This is a candidate solution. Store it and try a larger lambda to reduce count.
			ansS = currentS
			ansC = currentC
			ansLambda = midLambda
			low = midLambda + 1
		} else {
			// Not enough items. Need to decrease lambda to encourage picking more items.
			high = midLambda - 1
		}
	}

	// The result is ansS + ansLambda * cnt.
	// ansS = max(actual_sum - ansLambda * actual_count)
	// So, actual_sum = ansS + ansLambda * actual_count.
	// We want actual_sum for count = cnt.
	// If ansC > cnt, it means we picked ansC items. We need to discard (ansC - cnt) items.
	// Each discarded item reduces the sum by ansLambda.
	// So, actual_sum_for_cnt = (ansS + ansLambda * ansC) - ansLambda * (ansC - cnt) = ansS + ansLambda * cnt.
	return ansS + ansLambda*int64(cnt)
}