package solution

import "math"

func maxAbsValExpr(arr1 []int, arr2 []int) int {
	n := len(arr1)
	maxVal := 0

	// We are looking for the maximum of |arr1[i] - arr1[j]| + |arr2[i] - arr2[j]| + |i - j|.
	// This expression can be rewritten by considering the signs of the terms inside the absolute values.
	// For any a, b, c, d, e, f, the expression |a-b| + |c-d| + |e-f| is equivalent to
	// max over all s1, s2, s3 in {-1, 1} of (s1*(a-b) + s2*(c-d) + s3*(e-f)).
	// This can be rearranged as max over all s1, s2, s3 of (s1*a + s2*c + s3*e) - (s1*b + s2*d + s3*f).
	// Let f(k) = s1*arr1[k] + s2*arr2[k] + s3*k. We want to maximize f(i) - f(j).
	// This is equivalent to finding max(f(k)) - min(f(k)) over all k.
	// There are 2^3 = 8 combinations for (s1, s2, s3).
	// However, (s1, s2, s3) and (-s1, -s2, -s3) yield the same result because
	// max(-f(k)) - min(-f(k)) = -min(f(k)) - (-max(f(k))) = max(f(k)) - min(f(k)).
	// So we only need to check 4 unique combinations. We can fix s1=1.

	signs := [][]int{
		{1, 1, 1},
		{1, 1, -1},
		{1, -1, 1},
		{1, -1, -1},
	}

	for _, s := range signs {
		s1, s2, s3 := s[0], s[1], s[2]

		minCurrentSum := math.MaxInt32
		maxCurrentSum := math.MinInt32

		for k := 0; k < n; k++ {
			currentSum := s1*arr1[k] + s2*arr2[k] + s3*k
			if currentSum < minCurrentSum {
				minCurrentSum = currentSum
			}
			if currentSum > maxCurrentSum {
				maxCurrentSum = currentSum
			}
		}

		if (maxCurrentSum - minCurrentSum) > maxVal {
			maxVal = maxCurrentSum - minCurrentSum
		}
	}

	return maxVal
}