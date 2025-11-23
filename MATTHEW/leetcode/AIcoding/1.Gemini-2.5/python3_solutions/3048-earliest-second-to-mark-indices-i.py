import heapq

class Solution:
    def earliestSecondToMarkIndices(self, nums: list[int], changeIndices: list[int]) -> int:
        n = len(nums)
        m = len(changeIndices)

        def check(t: int) -> bool:
            if t == 0:
                return False

            last_occurrence = {}
            # Find the last occurrence of each index within the first 't' seconds (0-indexed)
            for s in range(t):
                idx = changeIndices[s]
                last_occurrence[idx] = s

            # If not all 'n' indices appear at least once, it's impossible to mark all.
            if len(last_occurrence) < n:
                return False

            pq = []  # Max-heap to store nums[idx-1] values for indices that are candidates to be marked.
                     # We store negative values to simulate a max-heap with heapq (min-heap).
            current_free_slots = 0
            marked_count = 0

            # Iterate backwards from t-1 down to 0
            for s in range(t - 1, -1, -1):
                idx = changeIndices[s]

                # If 's' is the last time 'idx' appears within the first 't' seconds,
                # then this is the last opportunity to decide to mark 'idx'.
                if s == last_occurrence[idx]:
                    # Add the 'cost' (nums[idx-1] decrements) to mark 'idx' to the priority queue.
                    # We will try to mark indices that require more decrements first if we have free slots.
                    heapq.heappush(pq, -nums[idx - 1])
                else:
                    # If 's' is not the last occurrence for 'idx', it means we have an earlier
                    # opportunity to operate on 'idx'. This slot can be used for a decrement.
                    # If 'idx' is already marked, or its decrements are done, this slot becomes "free"
                    # to be used for any other index's decrement.
                    current_free_slots += 1

                # Greedily mark indices if we have enough 'free_slots'.
                # We prioritize marking indices that require more decrements (higher nums[idx-1])
                # because we want to use our 'free_slots' for the most "expensive" marks first.
                # If we can mark the top candidate (highest cost), we do it.
                while pq and current_free_slots >= -pq[0]:
                    cost = -heapq.heappop(pq)
                    current_free_slots -= cost
                    marked_count += 1

            # All indices must be marked.
            return marked_count == n

        low = 1
        high = m
        ans = -1

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans