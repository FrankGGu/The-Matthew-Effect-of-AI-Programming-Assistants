class Solution:
    def sumOfFlooredPairs(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        max_num = max(nums) if nums else 0
        freq = [0] * (max_num + 1)
        prefix = [0] * (max_num + 1)

        for num in nums:
            freq[num] += 1

        for i in range(1, max_num + 1):
            prefix[i] = prefix[i - 1] + freq[i]

        res = 0
        for y in range(1, max_num + 1):
            if freq[y] == 0:
                continue
            for d in range(1, (max_num // y) + 1):
                lower = y * d
                upper = y * (d + 1) - 1
                upper = min(upper, max_num)
                count = prefix[upper] - prefix[lower - 1] if lower <= upper else 0
                res += freq[y] * d * count
                res %= MOD

        return res