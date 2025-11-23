class Solution:
    def minKBitFlips(self, nums: List[int], k: int) -> int:
        n = len(nums)
        flip = 0
        res = 0
        diff = [0] * (n + 1)
        for i in range(n):
            flip += diff[i]
            if (nums[i] + flip) % 2 == 0:
                if i + k > n:
                    return -1
                res += 1
                flip += 1
                diff[i] += 1
                if i + k < n:
                    diff[i + k] -= 1
        return res