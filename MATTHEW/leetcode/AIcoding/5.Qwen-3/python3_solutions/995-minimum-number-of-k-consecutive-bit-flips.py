class Solution:
    def minKBitFlips(self, nums: List[int], k: int) -> int:
        n = len(nums)
        flip = [0] * (n + 1)
        current_flips = 0
        result = 0

        for i in range(n):
            current_flips += flip[i]
            if nums[i] % 2 == 1 and current_flips % 2 == 0:
                result += 1
                current_flips += 1
                if i + k <= n:
                    flip[i + k] -= 1
            elif nums[i] % 2 == 0 and current_flips % 2 == 1:
                result += 1
                current_flips += 1
                if i + k <= n:
                    flip[i + k] -= 1

        return result