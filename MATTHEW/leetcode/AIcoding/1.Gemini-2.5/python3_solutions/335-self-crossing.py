class Solution:
    def isSelfCrossing(self, x: list[int]) -> bool:
        n = len(x)
        if n < 4:
            return False

        for i in range(3, n):
            # Case 1: The i-th segment crosses the (i-3)-th segment.
            # This happens when the path "narrows" and crosses an earlier segment.
            # For example, if we have segments N, W, S, E (d0, d1, d2, d3),
            # the East segment (d3) crosses the North segment (d0) if
            # d3 >= d1 (East is long enough to reach or pass West's x-coordinate)
            # AND d2 <= d0 (South is short enough that the path doesn't go below the start of North).
            if x[i] >= x[i-2] and x[i-1] <= x[i-3]:
                return True

            # Case 2: The i-th segment crosses the (i-4)-th segment.
            # This happens when the path "expands" and the current segment aligns with and crosses the 4th previous one.
            # For example, N, W, S, E, N (d0, d1, d2, d3, d4).
            # The second North segment (d4) crosses the first North segment (d0) if
            # d3 == d1 (East segment is same length as West, bringing path back to x=0)
            # AND d4 + d0 >= d2 (second North segment plus first North segment is long enough to cover South segment).
            if i >= 4:
                if x[i-1] == x[i-3] and x[i] + x[i-4] >= x[i-2]:
                    return True

            # Case 3: The i-th segment crosses the (i-5)-th segment.
            # This is a more complex "expanding" spiral crossing.
            # For example, N, W, S, E, N, W (d0, d1, d2, d3, d4, d5).
            # The second West segment (d5) crosses the first North segment (d0) if:
            # d3 >= d1 (outer East segment is long enough to cover inner West segment)
            # AND d4 >= d2 (outer North segment is long enough to cover inner South segment)
            # AND d4 <= d2 + d0 (outer North segment doesn't go too far, stays within the combined range of inner South and first North)
            # AND d5 + d1 >= d3 (second West segment plus inner West segment is long enough to cover outer East segment).
            if i >= 5:
                if x[i-2] >= x[i-4] and \
                   x[i-1] >= x[i-3] and \
                   x[i-1] <= x[i-3] + x[i-5] and \
                   x[i] + x[i-4] >= x[i-2]:
                    return True

        return False