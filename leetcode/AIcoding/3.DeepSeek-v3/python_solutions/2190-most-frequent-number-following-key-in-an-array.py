class Solution:
    def mostFrequent(self, nums: List[int], key: int) -> int:
        freq = {}
        max_count = 0
        result = -1

        for i in range(len(nums) - 1):
            if nums[i] == key:
                target = nums[i + 1]
                freq[target] = freq.get(target, 0) + 1
                if freq[target] > max_count:
                    max_count = freq[target]
                    result = target

        return result