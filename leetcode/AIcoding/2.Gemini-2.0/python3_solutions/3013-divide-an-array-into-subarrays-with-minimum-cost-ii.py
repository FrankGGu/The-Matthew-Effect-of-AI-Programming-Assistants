import heapq

class Solution:
    def minCost(self, nums: list[int], k: int, dist: int) -> int:
        n = len(nums)
        res = float('inf')

        for i in range(1, n - dist):
            cost = nums[0]

            candidates = []
            for j in range(1, n):
                candidates.append((nums[j], j))

            candidates.sort()

            subarray_cost = 0
            count = 0

            chosen_indices = set()

            for val, idx in candidates:
                if idx >= i and idx <= i + dist -1:
                    subarray_cost += val
                    count += 1
                    chosen_indices.add(idx)
                    if count == k:
                        break

            if count == k:
                res = min(res, cost + subarray_cost)

        return res