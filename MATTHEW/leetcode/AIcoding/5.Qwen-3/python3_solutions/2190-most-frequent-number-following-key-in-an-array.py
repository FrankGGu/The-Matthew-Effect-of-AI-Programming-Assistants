from collections import defaultdict

class Solution:
    def mostFrequent(self, nums: List[int], key: int) -> int:
        count = defaultdict(int)
        max_freq = 0
        result = nums[0]

        for i in range(1, len(nums)):
            if nums[i - 1] == key:
                count[nums[i]] += 1
                if count[nums[i]] > max_freq:
                    max_freq = count[nums[i]]
                    result = nums[i]

        return result