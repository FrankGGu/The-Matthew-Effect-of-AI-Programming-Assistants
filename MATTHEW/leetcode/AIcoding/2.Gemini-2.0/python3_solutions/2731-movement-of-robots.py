class Solution:
    def sumDistance(self, nums: List[int], s: str, d: int) -> int:
        n = len(nums)
        positions = []
        for i in range(n):
            if s[i] == 'L':
                positions.append(nums[i] - d)
            else:
                positions.append(nums[i] + d)

        positions.sort()

        ans = 0
        prefix_sum = 0
        mod = 10**9 + 7

        for i in range(n):
            ans = (ans + (positions[i] * i - prefix_sum)) % mod
            prefix_sum = (prefix_sum + positions[i]) % mod

        return ans