class Solution:
    def divideArray(self, nums: List[int]) -> bool:
        counts = {}
        for num in nums:
            counts[num] = counts.get(num, 0) + 1
        for count in counts.values():
            if count % 2 != 0:
                return False
        return True