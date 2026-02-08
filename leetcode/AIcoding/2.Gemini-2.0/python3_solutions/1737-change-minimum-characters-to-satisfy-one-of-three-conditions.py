class Solution:
    def minCharacters(self, a: str, b: str) -> int:
        n = len(a)
        m = len(b)

        def solve(s1, s2):
            ans = float('inf')
            for c in range(ord('a'), ord('z') + 1):
                char = chr(c)
                count1 = 0
                count2 = 0
                for ch in s1:
                    if ch >= char:
                        count1 += 1
                for ch in s2:
                    if ch < char:
                        count2 += 1
                ans = min(ans, count1 + count2)
            return ans

        count_a = [0] * 26
        count_b = [0] * 26
        for char in a:
            count_a[ord(char) - ord('a')] += 1
        for char in b:
            count_b[ord(char) - ord('a')] += 1

        ans = float('inf')
        ans = min(ans, solve(a, b))
        ans = min(ans, solve(b, a))

        for i in range(26):
            ans = min(ans, n - count_a[i] + m - count_b[i])

        return ans