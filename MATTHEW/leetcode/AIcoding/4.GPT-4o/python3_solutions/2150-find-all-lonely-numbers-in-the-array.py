class Solution:
    def findLonely(self, nums: List[int]) -> List[int]:
        count = Counter(nums)
        return [num for num in count if count[num] == 1 and num - 1 not in count and num + 1 not in count]