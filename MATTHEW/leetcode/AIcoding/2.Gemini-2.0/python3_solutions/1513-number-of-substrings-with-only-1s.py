class Solution:
    def numSub(self, s: str) -> int:
        count = 0
        ans = 0
        for c in s:
            if c == '1':
                count += 1
            else:
                ans += count * (count + 1) // 2
                count = 0
        ans += count * (count + 1) // 2
        return ans % (10**9 + 7)