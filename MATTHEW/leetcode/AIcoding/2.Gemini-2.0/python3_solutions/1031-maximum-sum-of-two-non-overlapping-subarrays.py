class Solution:
    def maxSumTwoNoOverlap(self, nums: list[int], firstLen: int, secondLen: int) -> int:
        def max_sum(first_len, second_len):
            max_first = 0
            curr_first = sum(nums[:first_len])
            max_sum_overall = 0

            for i in range(first_len, len(nums)):
                curr_first += nums[i] - nums[i - first_len]
                max_first = max(max_first, curr_first)

                if i >= first_len + second_len - 1:
                    curr_second = sum(nums[i - second_len + 1: i + 1])
                    max_sum_overall = max(max_sum_overall, max_first + curr_second)

            max_first = 0
            curr_first = sum(nums[-first_len:])
            for i in range(len(nums) - first_len - 1, -1, -1):
              curr_first += nums[i] - nums[i + first_len]
              max_first = max(max_first, curr_first)
              if i <= len(nums) - first_len - second_len:
                  curr_second = sum(nums[i: i + second_len])
                  max_sum_overall = max(max_sum_overall, max_first + curr_second)

            return max_sum_overall

        return max(max_sum(firstLen, secondLen), max_sum(secondLen, firstLen))