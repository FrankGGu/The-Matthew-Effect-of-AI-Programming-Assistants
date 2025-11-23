from collections import defaultdict

class Solution:
    def findAnagrams(self, s: str, p: str) -> List[int]:
        if len(p) > len(s):
            return []

        p_count = defaultdict(int)
        s_count = defaultdict(int)

        for i in range(len(p)):
            p_count[p[i]] += 1
            s_count[s[i]] += 1

        result = []
        if s_count == p_count:
            result.append(0)

        for i in range(len(p), len(s)):
            s_count[s[i - len(p)]] -= 1
            if s_count[s[i - len(p)]] == 0:
                del s_count[s[i - len(p)]]
            s_count[s[i]] += 1

            if s_count == p_count:
                result.append(i - len(p) + 1)

        return result