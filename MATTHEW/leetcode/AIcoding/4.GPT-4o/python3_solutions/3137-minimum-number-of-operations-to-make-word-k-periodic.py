class Solution:
    def minimumOperations(self, s: str, k: int) -> int:
        n = len(s)
        ans = 0

        for i in range(k):
            count = [0] * 26
            for j in range(i, n, k):
                count[ord(s[j]) - ord('a')] += 1
            max_freq = max(count)
            ans += (n // k) - max_freq

        return ans