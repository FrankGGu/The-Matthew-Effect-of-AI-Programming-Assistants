class Solution:
    def subArrayXor(self, nums: List[int], k: int) -> int:
        xor = 0
        freq = {0: 1}
        count = 0
        for i in range(len(nums)):
            xor ^= nums[i]
            target = xor ^ k
            if target in freq:
                count += freq[target]
            if xor in freq:
                freq[xor] += 1
            else:
                freq[xor] = 1
        return count