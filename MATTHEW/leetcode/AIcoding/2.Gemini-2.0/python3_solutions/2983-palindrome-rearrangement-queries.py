class Solution:
    def canMakePalindromeQueries(self, s: str, queries: list[list[int]]) -> list[bool]:
        n = len(s)
        pref = [0] * (n + 1)
        for i in range(n // 2):
            if s[i] != s[n - 1 - i]:
                pref[i + 1] = pref[i] + 1
            else:
                pref[i + 1] = pref[i]

        pref = pref[1:]

        result = []
        for l1, r1, l2, r2 in queries:
            left = min(l1, l2)
            right = max(r1, r2)

            diff = pref[right] - (pref[left -1] if left > 0 else 0)

            if diff <= (right - left + 1) // 2:
                result.append(True)
            else:
                result.append(False)

        return result