class Solution:
    def findMaxLength(self, nums: List[int]) -> int:
        max_len = 0
        count = 0
        sum_map = {0: -1}

        for i in range(len(nums)):
            if nums[i] == 0:
                count -= 1
            else:
                count += 1

            if count in sum_map:
                max_len = max(max_len, i - sum_map[count])
            else:
                sum_map[count] = i

        return max_len