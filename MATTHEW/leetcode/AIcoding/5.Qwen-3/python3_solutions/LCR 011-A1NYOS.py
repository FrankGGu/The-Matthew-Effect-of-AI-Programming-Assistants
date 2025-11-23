class Solution:
    def findMaxLength(self, nums: List[int]) -> int:
        count = 0
        max_length = 0
        hash_map = {0: -1}
        for i in range(len(nums)):
            count += 1 if nums[i] == 1 else -1
            if count in hash_map:
                max_length = max(max_length, i - hash_map[count])
            else:
                hash_map[count] = i
        return max_length