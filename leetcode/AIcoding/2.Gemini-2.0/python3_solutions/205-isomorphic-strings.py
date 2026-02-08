class Solution:
    def isIsomorphic(self, s: str, t: str) -> bool:
        s_map = {}
        t_map = {}
        for i in range(len(s)):
            s_char = s[i]
            t_char = t[i]
            if s_char not in s_map and t_char not in t_map:
                s_map[s_char] = t_char
                t_map[t_char] = s_char
            elif s_char in s_map and t_char in t_map:
                if s_map[s_char] != t_char or t_map[t_char] != s_char:
                    return False
            else:
                return False
        return True