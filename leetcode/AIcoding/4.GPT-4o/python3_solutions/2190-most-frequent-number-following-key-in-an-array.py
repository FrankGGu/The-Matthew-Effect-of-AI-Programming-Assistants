class Solution:
    def mostFrequent(self, nums: List[int], key: int) -> int:
        count = {}
        for i in range(len(nums) - 1):
            if nums[i] == key:
                if nums[i + 1] in count:
                    count[nums[i + 1]] += 1
                else:
                    count[nums[i + 1]] = 1
        return max(count, key=count.get)