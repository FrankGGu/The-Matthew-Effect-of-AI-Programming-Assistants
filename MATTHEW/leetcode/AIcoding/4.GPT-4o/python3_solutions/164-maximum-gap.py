class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        if len(nums) < 2:
            return 0
        max_num, min_num = max(nums), min(nums)
        if max_num == min_num:
            return 0
        bucket_size = max(1, (max_num - min_num) // (len(nums) - 1))
        bucket_count = (max_num - min_num) // bucket_size + 1
        buckets = [[float('inf'), float('-inf')] for _ in range(bucket_count)]

        for num in nums:
            idx = (num - min_num) // bucket_size
            buckets[idx][0] = min(buckets[idx][0], num)
            buckets[idx][1] = max(buckets[idx][1], num)

        max_gap = 0
        prev_max = min_num

        for low, high in buckets:
            if low == float('inf'):
                continue
            max_gap = max(max_gap, low - prev_max)
            prev_max = high

        return max_gap