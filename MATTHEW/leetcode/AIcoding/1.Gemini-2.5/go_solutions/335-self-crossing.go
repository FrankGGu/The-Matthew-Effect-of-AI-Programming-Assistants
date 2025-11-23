func isSelfCrossing(distance []int) bool {
	n := len(distance)
	if n <= 3 {
		return false
	}

	for i := 3; i < n; i++ {
		// Case 1: The i-th line segment crosses the (i-3)-th line segment.
		// This happens when the path is spiraling inward and the current segment
		// 'distance[i]' is long enough to cross 'distance[i-2]',
		// AND the previous segment 'distance[i-1]' is shorter than or equal to
		// 'distance[i-3]', preventing it from extending past the start of 'distance[i-3]'.
		if distance[i] >= distance[i-2] && distance[i-1] <= distance[i-3] {
			return true
		}

		// Case 2: The i-th line segment touches or crosses the (i-4)-th line segment.
		// This happens when the path forms a closed loop or nearly closed loop.
		// The condition is that 'distance[i-1]' (e.g., East) equals 'distance[i-3]' (e.g., West),
		// forming a rectangle, AND the current segment 'distance[i]' (e.g., North)
		// plus 'distance[i-4]' (e.g., North) is long enough to cross or touch 'distance[i-2]' (e.g., South).
		if i >= 4 {
			if distance[i-1] == distance[i-3] && distance[i]+distance[i-4] >= distance[i-2] {
				return true
			}
		}

		// Case 3: The i-th line segment touches or crosses the (i-5)-th line segment.
		// This is the most complex 'inner spiral' crossing.
		// This occurs when the path forms an inner rectangle that crosses an even older segment.
		// Conditions:
		// 1. 'distance[i-2]' (e.g., South) must be at least as long as 'distance[i-4]' (e.g., North),
		//    ensuring the inner spiral is 'wide' enough.
		// 2. 'distance[i-1]' (e.g., East) plus 'distance[i-5]' (e.g., East) must be long enough
		//    to cross 'distance[i-3]' (e.g., West). This ensures the horizontal crossing.
		// 3. 'distance[i]' (e.g., North) plus 'distance[i-4]' (e.g., North) must be long enough
		//    to cross 'distance[i-2]' (e.g., South). This ensures the vertical crossing.
		if i >= 5 {
			if distance[i-2] >= distance[i-4] &&
				distance[i-1]+distance[i-5] >= distance[i-3] &&
				distance[i]+distance[i-4] >= distance[i-2] {
				return true
			}
		}
	}

	return false
}