class Solution:
    def minimalKSum(self, nums: List[int], k: int) -> int:
        nums = set(nums)
        result = 0
        current = 1

        while k > 0:
            if current not in nums:
                result += current
                k -= 1
            current += 1

        return result