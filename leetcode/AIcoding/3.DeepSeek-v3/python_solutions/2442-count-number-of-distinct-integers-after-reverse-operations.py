class Solution:
    def countDistinctIntegers(self, nums: List[int]) -> int:
        distinct = set(nums)
        for num in nums:
            reversed_num = int(str(num)[::-1])
            distinct.add(reversed_num)
        return len(distinct)