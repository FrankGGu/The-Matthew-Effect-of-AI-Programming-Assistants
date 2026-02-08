class Solution:
    def countPairs(self, hours: list[int]) -> int:
        remainder_counts = [0] * 24
        ans = 0

        for h in hours:
            r = h % 24

            if r == 0:
                ans += remainder_counts[0]
            elif r == 12:
                ans += remainder_counts[12]
            else:
                target_r = 24 - r
                ans += remainder_counts[target_r]

            remainder_counts[r] += 1

        return ans