class Solution:
    def canBeEqual(self, s1: str, s2: str) -> bool:
        if s1 == s2:
            return True
        s1_list = list(s1)
        if s1_list[0] == s2[2] and s1_list[2] == s2[0] and s1_list[1] == s2[3] and s1_list[3] == s2[1]:
            return True
        if s1_list[0] == s2[0] and s1_list[2] == s2[2] and s1_list[1] == s2[3] and s1_list[3] == s2[1]:
            return True
        if s1_list[0] == s2[2] and s1_list[2] == s2[0] and s1_list[1] == s2[1] and s1_list[3] == s2[3]:
            return True
        return False