class Solution:
    def minimumOperations(self, num: str) -> int:
        n = len(num)
        ans = n
        for i in range(n):
            for j in range(i + 1, n):
                val = int(num[i] + num[j])
                if val % 25 == 0:
                    ans = min(ans, n - j - 1 + j - i - 1)
        return ans