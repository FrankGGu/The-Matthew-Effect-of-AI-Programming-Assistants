class Solution:
    def divideArray(self, nums: List[int]) -> bool:
        from collections import Counter
        count = Counter(nums)
        return all(v % 2 == 0 for v in count.values())