class Solution:
    def canBeEqual(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        odd_s = []
        even_s = []
        odd_t = []
        even_t = []
        for i in range(len(s)):
            if i % 2 == 0:
                even_s.append(s[i])
                even_t.append(t[i])
            else:
                odd_s.append(s[i])
                odd_t.append(t[i])
        return sorted(odd_s) == sorted(odd_t) and sorted(even_s) == sorted(even_t)