class Solution:
    def maximumSum(self, nums: List[int]) -> int:
        from collections import defaultdict

        def digit_sum(n):
            return sum(int(d) for d in str(n))

        map = defaultdict(list)
        for num in nums:
            s = digit_sum(num)
            map[s].append(num)

        max_sum = -1
        for key in map:
            if len(map[key]) >= 2:
                sorted_nums = sorted(map[key], reverse=True)
                max_sum = max(max_sum, sorted_nums[0] + sorted_nums[1])

        return max_sum