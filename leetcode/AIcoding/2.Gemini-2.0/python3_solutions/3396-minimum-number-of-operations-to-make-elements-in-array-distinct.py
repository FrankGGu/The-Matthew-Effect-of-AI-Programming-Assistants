class Solution:
    def minOperations(self, nums: List[int]) -> int:
        nums.sort()
        operations = 0
        seen = set()
        for num in nums:
            if num in seen:
                while num in seen:
                    num += 1
                    operations += 1
            seen.add(num)
        return operations