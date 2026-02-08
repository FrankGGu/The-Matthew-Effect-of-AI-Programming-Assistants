import "math"

func secondsToRemoveOccurrences(s string) int {
	zeros := 0
	ans := 0

	for i := 0; i < len(s); i++ {
		if s[i] == '0' {
			zeros++
		} else { // s[i] == '1'
			if zeros > 0 { // If there are '0's to the left of this '1'
				// This '1' needs to move right past 'zeros' '0's.
				// The time taken is determined by two factors:
				// 1. The time taken for previous operations plus one more second for this '1' to move. (ans + 1)
				// 2. The number of '0's this '1' has to move past. (zeros)
				// We take the maximum of these two to account for the simultaneous nature of swaps.
				// 'ans + 1' captures the sequential progression of time for '1's moving.
				// 'zeros' captures the "density" of '0's that need to be cleared by this '1'.
				ans = int(math.Max(float64(ans+1), float64(zeros)))
			}
		}
	}

	return ans
}