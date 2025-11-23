from collections import defaultdict

class Solution:
    def countSubstrings(self, s: str, t: str) -> int:
        n, m = len(s), len(t)
        ans = 0
        for i in range(n):
            for j in range(i, n):
                sub = s[i:j+1]
                if len(sub) >= m:
                    for k in range(len(sub) - m + 1):
                        sub_sub = sub[k:k+m]
                        s_count = defaultdict(int)
                        t_count = defaultdict(int)
                        for char in sub_sub:
                            s_count[char] += 1
                        for char in t:
                            t_count[char] += 1
                        diff = 0
                        for char in 'abcdefghijklmnopqrstuvwxyz':
                            diff += abs(s_count[char] - t_count[char])
                        if diff <= 2:
                            ans += 1
        return ans