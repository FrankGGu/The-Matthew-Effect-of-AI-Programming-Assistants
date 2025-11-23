class Solution:
    def findMaxLength(self, nums: List[int]) -> int:
        count_map = {0: -1}
        max_length = count = 0

        for i, num in enumerate(nums):
            count += 1 if num == 1 else -1
            if count in count_map:
                max_length = max(max_length, i - count_map[count])
            else:
                count_map[count] = i

        return max_length