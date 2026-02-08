import heapq

class Solution:
    def earliestSecondToMarkIndices(self, nums: list[int], changeIndices: list[int]) -> int:
        m = len(nums)
        n_ci = len(changeIndices)

        def can(T: int) -> bool:
            last_occurrence = [-1] * m
            # For each index i, find the latest second k+1 <= T
            # where changeIndices[k] == i.
            # changeIndices is 0-indexed, so changeIndices[k] corresponds to second k+1.
            for k in range(min(T, n_ci)):
                idx = changeIndices[k]
                last_occurrence[idx] = k + 1

            mark_opportunities = [] # List of (latest_mark_time, index)
            for i in range(m):
                if last_occurrence[i] == -1:
                    return False # Index i cannot be marked by time T
                mark_opportunities.append((last_occurrence[i], i))

            # Sort opportunities by their latest possible mark time in ascending order.
            # This allows processing them chronologically.
            mark_opportunities.sort()

            available_slots = 0 # Net count of operations available for decrementing
            marked_count = 0

            # Max-heap to store nums[i] values of indices that are candidates for marking
            # at or before the current second. We store negative values to simulate a max-heap.
            pq = [] 

            ptr = 0 # Pointer for mark_opportunities list
            for s in range(1, T + 1):
                # At second 's', add all indices whose latest mark time is 's' to the priority queue.
                # These indices must be marked by second 's' if we want to use their latest opportunity.
                while ptr < m and mark_opportunities[ptr][0] == s:
                    idx = mark_opportunities[ptr][1]
                    heapq.heappush(pq, -nums[idx]) # Push negative nums[idx] for max-heap behavior
                    ptr += 1

                if pq:
                    # If there are candidate indices to mark, use the current second 's' to mark one.
                    # Greedily choose the index 'i' with the largest nums[i] value.
                    # This strategy ensures that we prioritize marking indices that require more
                    # decrement operations, as they are "harder" to satisfy.
                    val = -heapq.heappop(pq) # Get the largest nums[i]
                    available_slots -= val # Commit 'val' decrement operations
                    marked_count += 1
                else:
                    # No indices need to be marked at this specific second 's'.
                    # Use this second 's' as a free decrement operation.
                    available_slots += 1

            # All indices must be marked, and we must have enough decrement slots (non-negative available_slots).
            return marked_count == m and available_slots >= 0

        low = 1
        # The upper bound for T can be estimated as the sum of all nums[i] values plus
        # the total number of marking opportunities (n_ci).
        # sum(nums) can be up to 10^5 * 10^9 = 10^14. n_ci up to 10^5.
        # Python handles large integers automatically.
        high = n_ci + sum(nums) + m # A sufficiently large upper bound

        ans = -1

        while low <= high:
            mid = (low + high) // 2
            if can(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans