import (
	"sort"
)

func intersectionSizeTwo(intervals [][]int) int {
	// Sort intervals:
	// 1. By end point in ascending order.
	// 2. If end points are equal, by start point in descending order.
	sort.Slice(intervals, func(i, j int) bool {
		if intervals[i][1] != intervals[j][1] {
			return intervals[i][1] < intervals[j][1]
		}
		return intervals[i][0] > intervals[j][0]
	})

	ans := 0
	// p1 and p2 are the two largest points in the intersection set S chosen so far, with p1 < p2.
	// Initialize them to values smaller than any possible interval start.
	// -2 and -1 are safe as interval starts are non-negative.
	p1 := -2
	p2 := -1

	for _, interval := range intervals {
		a, b := interval[0], interval[1]

		// Case 1: Current interval [a, b] is fully covered by p1 and p2.
		// This means both p1 and p2 are within [a, b].
		// Since p1 < p2, we only need to check if a <= p1.
		if a <= p1 {
			// Both p1 and p2 are in [a, b]. No need to add new points.
			continue
		}

		// Case 2: Current interval [a, b] is partially covered by p2, but not p1.
		// This means a <= p2, but a > p1.
		// We need one more point to cover [a, b].
		// To maximize its utility for future intervals (which have larger end points),
		// we add 'b' as the new largest point.
		if a <= p2 {
			ans++
			p1 = p2 // The previous p2 becomes the new p1
			p2 = b  // The new point 'b' becomes the new p2
			continue
		}

		// Case 3: Current interval [a, b] is not covered by p1 or p2 at all.
		// This means a > p2 (and implicitly a > p1).
		// We need two new points to cover [a, b].
		// To maximize their utility, we add 'b-1' and 'b'.
		ans += 2
		p1 = b - 1
		p2 = b
	}

	return ans
}