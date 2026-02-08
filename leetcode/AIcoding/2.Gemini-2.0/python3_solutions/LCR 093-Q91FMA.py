class Solution:
    def lenLongestFibSubseq(self, arr: list[int]) -> int:
        s = set(arr)
        n = len(arr)
        ans = 0
        for i in range(n):
            for j in range(i + 1, n):
                a, b = arr[i], arr[j]
                length = 2
                while a + b in s:
                    a, b = b, a + b
                    length += 1
                ans = max(ans, length)
        return ans if ans > 2 else 0