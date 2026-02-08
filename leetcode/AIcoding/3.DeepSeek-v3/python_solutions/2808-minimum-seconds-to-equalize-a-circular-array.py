class Solution:
    def minimumSeconds(self, nums: List[int]) -> int:
        from collections import defaultdict
        num_indices = defaultdict(list)
        for i, num in enumerate(nums):
            num_indices[num].append(i)

        n = len(nums)
        min_time = float('inf')

        for num in num_indices:
            indices = num_indices[num]
            max_gap = 0
            m = len(indices)
            for i in range(m):
                prev = indices[i-1] if i > 0 else indices[-1] - n
                gap = indices[i] - prev - 1
                max_gap = max(max_gap, gap)
            current_time = (max_gap + 1) // 2
            min_time = min(min_time, current_time)

        return min_time