class Solution:
    def minDifference(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        from bisect import bisect_left, bisect_right

        num_indices = {}
        for idx, num in enumerate(nums):
            if num not in num_indices:
                num_indices[num] = []
            num_indices[num].append(idx)

        unique_nums = sorted(num_indices.keys())
        res = []

        for l, r in queries:
            candidates = []
            for num in unique_nums:
                indices = num_indices[num]
                left_pos = bisect_left(indices, l)
                right_pos = bisect_right(indices, r)
                if right_pos > left_pos:
                    candidates.append(num)

            min_diff = float('inf')
            for i in range(1, len(candidates)):
                min_diff = min(min_diff, candidates[i] - candidates[i-1])

            if min_diff != float('inf'):
                res.append(min_diff)
            else:
                res.append(-1)

        return res