import heapq

class Solution:
    def minIncrementOperations(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # Transform the problem:
        # The condition nums[i+1] >= nums[i] + k can be rewritten as:
        # nums[i+1] - (i+1)*k >= nums[i] - i*k
        # Let b[i] = nums[i] - i*k.
        # Then the condition becomes b[i+1] >= b[i].
        # So we need to make the array b non-decreasing.

        # We are allowed to increment nums[i] by 1 with cost 1.
        # If we increment nums[i] to nums[i] + x, the cost is x.
        # This changes b[i] to (nums[i] + x) - i*k = b[i] + x.
        # So, incrementing b[i] by x costs x.
        # We must have new_nums[i] >= nums[i], which means new_b[i] >= b[i].

        # The problem is now: given array b, find minimum cost to make it non-decreasing,
        # where new_b[i] >= b[i] for all i, and cost is sum(new_b[i] - b[i]).

        # This is a standard problem solvable with a max-heap.
        # The heap stores the negative values of the elements of the resulting non-decreasing array.
        # Using negative values simulates a max-heap with Python's min-heap.

        cost = 0
        pq = [] # Max-heap (stores -val)

        for i in range(n):
            val = nums[i] - i * k

            # Add the current value to the heap.
            heapq.heappush(pq, -val)

            # If the current value is less than the maximum value seen so far (top of heap),
            # we need to increment it to match the maximum to maintain non-decreasing property.
            # The cost is the difference.
            # We then pop the old maximum and push the current value (which is now incremented to the maximum).
            # This ensures that the elements in the heap, when sorted, represent the optimal non-decreasing array.
            # The new_b[i] >= b[i] constraint is implicitly handled because we only increment values.
            # If val < -pq[0], we increment val to -pq[0], so new_val = -pq[0].
            # Since -pq[0] is a value that some b[j] (j<i) was set to, and b[j] >= original b[j],
            # it implies -pq[0] >= original b[j].
            # If new_val = -pq[0] >= val, and val = original b[i], then new_val >= original b[i].
            # This logic works.

            if -pq[0] > val:
                cost += (-pq[0] - val)
                heapq.heappop(pq)
                heapq.heappush(pq, -val)

        return cost