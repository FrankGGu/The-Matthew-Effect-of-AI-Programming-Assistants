class Solution:
    def sumDistance(self, nums: List[int], s: str, d: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        final_positions = []

        for i in range(n):
            if s[i] == 'L':
                final_positions.append(nums[i] - d)
            else:
                final_positions.append(nums[i] + d)

        final_positions.sort()
        prefix = [0] * (n + 1)
        res = 0

        for i in range(n):
            prefix[i+1] = prefix[i] + final_positions[i]

        for i in range(n):
            res += final_positions[i] * i - prefix[i]
            res %= MOD

        return res