class Solution:
    def maximumSum(self, nums: List[int]) -> int:
        def digit_sum(num):
            s = 0
            while num > 0:
                s += num % 10
                num = num // 10
            return s

        sum_map = {}
        max_sum = -1

        for num in nums:
            s = digit_sum(num)
            if s in sum_map:
                if num + sum_map[s] > max_sum:
                    max_sum = num + sum_map[s]
                if num > sum_map[s]:
                    sum_map[s] = num
            else:
                sum_map[s] = num

        return max_sum