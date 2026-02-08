class Solution:
    def findDifferentBinaryString(self, nums: List[str]) -> str:
        n = len(nums[0])
        seen = set(nums)

        for num in range(2**n):
            binary = bin(num)[2:].zfill(n)
            if binary not in seen:
                return binary
        return ""