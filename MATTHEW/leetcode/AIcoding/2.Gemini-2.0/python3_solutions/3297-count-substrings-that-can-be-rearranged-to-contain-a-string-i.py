from collections import Counter

class Solution:
    def countSubstrings(self, s: str, t: str) -> int:
        n = len(s)
        m = len(t)
        ans = 0
        for i in range(1, min(n, m) + 1):
            for j in range(n - i + 1):
                sub = s[j:j+i]
                for k in range(m - i + 1):
                    sub_t = t[k:k+i]
                    diff = 0
                    for l in range(i):
                        if sub[l] != sub_t[l]:
                            diff += 1
                    if diff == 1:
                        ans += 1
        return ans