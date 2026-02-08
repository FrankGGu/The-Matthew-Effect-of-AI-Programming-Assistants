import collections

class Solution:
    def maximumSum(self, nums: list[int], m: int, k: int) -> int:
        n = len(nums)
        if n < k:
            return 0

        current_sum = 0
        max_sum = 0
        freq_map = collections.defaultdict(int)
        distinct_count = 0

        for i in range(k):
            num = nums[i]
            current_sum += num
            if freq_map[num] == 0:
                distinct_count += 1
            freq_map[num] += 1

        if distinct_count >= m:
            max_sum = current_sum

        for i in range(k, n):
            new_num = nums[i]
            current_sum += new_num
            if freq_map[new_num] == 0:
                distinct_count += 1
            freq_map[new_num] += 1

            old_num = nums[i - k]
            current_sum -= old_num
            freq_map[old_num] -= 1
            if freq_map[old_num] == 0:
                distinct_count -= 1

            if distinct_count >= m:
                max_sum = max(max_sum, current_sum)

        return max_sum