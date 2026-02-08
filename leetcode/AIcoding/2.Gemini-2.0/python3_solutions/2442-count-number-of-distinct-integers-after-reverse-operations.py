class Solution:
    def countDistinctIntegers(self, nums: List[int]) -> int:
        s = set(nums)
        for num in nums:
            s.add(int(str(num)[::-1]))
        return len(s)