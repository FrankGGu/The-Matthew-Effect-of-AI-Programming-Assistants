class Solution:
    def minKBitFlips(self, nums: List[int], k: int) -> int:
        n = len(nums)
        flips = 0
        flipped = [0] * n
        count = 0
        for i in range(n):
            if i >= k:
                count -= flipped[i - k]
            if (nums[i] + count) % 2 == 0:
                if i + k > n:
                    return -1
                flips += 1
                flipped[i] = 1
                count += 1
        return flips