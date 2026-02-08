class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        ans = 0
        last_a = -1
        last_b = -1
        last_c = -1

        n = len(s)
        for j in range(n):
            if s[j] == 'a':
                last_a = j
            elif s[j] == 'b':
                last_b = j
            elif s[j] == 'c':
                last_c = j

            if last_a != -1 and last_b != -1 and last_c != -1:
                ans += min(last_a, last_b, last_c) + 1

        return ans