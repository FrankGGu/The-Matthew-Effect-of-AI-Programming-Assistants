import (
	"strconv"
	"strings"
)

func queryString(s string, n int) bool {
	effectiveN := n

	// Optimization: Determine the effective upper bound for 'i'.
	// We only need to check integers 'i' such that their binary representation
	// could possibly be a substring of 's'.
	// The maximum length of a binary string that can be a substring of 's' is len(s).
	// The largest integer whose binary representation has length L is (1 << L) - 1.
	// So, we only need to check integers up to min(n, (1 << len(s)) - 1).

	// Handle potential overflow for (1 << len(s)) - 1.
	// If len(s) is large (e.g., >= 30, as n <= 10^9 < 2^30), then (1 << len(s)) - 1
	// will be greater than or equal to n. In this case, the effective upper bound is n.
	// If len(s) is smaller than 30, (1 << len(s)) - 1 might be less than n,
	// and it's safe to compute using int64.
	if len(s) < 30 { // 2^29 - 1 is ~5*10^8, 2^30 - 1 is ~10^9.
		// If len(s) is small enough, (1 << len(s)) - 1 might be less than n.
		// And (1 << len(s)) - 1 is guaranteed to fit in int64 and be positive.
		maxValFromSLength := (int64(1) << len(s)) - 1
		if int64(n) > maxValFromSLength {
			effectiveN = int(maxValFromSLength)
		}
	}
	// If len(s) >= 30, then (1 << len(s)) - 1 is >= 2^30 - 1 which is > 10^9 (max n).
	// So, n will always be <= (1 << len(s)) - 1.
	// In this case, effectiveN remains n.

	// Iterate from 1 up to the determined effective upper bound.
	for i := 1; i <= effectiveN; i++ {
		binStr := strconv.FormatInt(int64(i), 2)
		if !strings.Contains(s, binStr) {
			return false
		}
	}

	return true
}