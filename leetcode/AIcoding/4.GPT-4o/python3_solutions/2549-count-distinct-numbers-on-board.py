class Solution:
    def distinctNumbers(self, nums: List[int]) -> List[int]:
        count = []
        seen = set()
        for num in nums:
            seen.add(num)
            count.append(len(seen))
        return count