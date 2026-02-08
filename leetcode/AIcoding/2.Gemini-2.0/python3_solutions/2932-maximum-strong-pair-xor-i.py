class Solution:
    def maximumStrongPairXor(self, nums: List[int]) -> int:
        nums.sort()
        max_xor = 0
        for i in range(len(nums)):
            for j in range(i, len(nums)):
                if nums[j] <= 2 * nums[i]:
                    max_xor = max(max_xor, nums[i] ^ nums[j])
                else:
                    break
        return max_xor