from sortedcontainers import SortedDict, SortedList

class Solution:
    def blockPlacementQueries(self, n: int, queries: List[List[int]]) -> List[int]:
        # free_intervals stores available free segments.
        # Key: start coordinate of a free segment
        # Value: end coordinate of a free segment
        free_intervals = SortedDict({0: n - 1}) 

        # free_lengths stores the lengths of all currently available free segments.
        # This allows efficient retrieval of the minimum length (free_lengths[0]).
        free_lengths = SortedList([n]) 

        results = []

        for x, y in queries:
            # Find the free interval [start_key, end_val] that contains the starting point x.
            # SortedDict.bisect_right(x) returns an index `i` such that all keys `k`
            # in `free_intervals.keys()` with `k < x` are to the left of `i`, and
            # all keys `k` with `k >= x` are to the right of `i`.
            # We need the largest key `k` such that `k <= x`. This is `free_intervals.keys()[idx-1]`.
            idx = free_intervals.bisect_right(x) - 1
            start_key = free_intervals.keys()[idx]
            end_val = free_intervals[start_key]

            # Remove the old, larger free interval that is now being partially occupied.
            free_intervals.pop(start_key)
            free_lengths.remove(end_val - start_key + 1)

            # Calculate the end coordinate of the new block.
            block_end_coord = x + y - 1

            # If there's a free segment to the left of the new block, add it.
            if x > start_key:
                new_len_left = x - start_key
                free_intervals[start_key] = x - 1
                free_lengths.add(new_len_left)

            # If there's a free segment to the right of the new block, add it.
            if block_end_coord < end_val:
                new_len_right = end_val - (block_end_coord + 1) + 1
                free_intervals[block_end_coord + 1] = end_val
                free_lengths.add(new_len_right)

            # After placing the block and updating free segments,
            # the minimum length L that can be placed anywhere is the smallest length
            # in the `free_lengths` list.
            if not free_lengths:
                results.append(-1)
            else:
                results.append(free_lengths[0])

        return results