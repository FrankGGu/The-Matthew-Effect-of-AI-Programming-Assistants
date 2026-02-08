from typing import List

class Solution:
    def findLUSlength(self, strs: List[str]) -> int:
        def isSubsequence(s1: str, s2: str) -> bool:
            i = 0
            j = 0
            while i < len(s1) and j < len(s2):
                if s1[i] == s2[j]:
                    i += 1
                j += 1
            return i == len(s1)

        max_len = -1
        n = len(strs)

        for i in range(n):
            s_i = strs[i]
            is_uncommon = True
            for j in range(n):
                if i == j:
                    continue
                if isSubsequence(s_i, strs[j]):
                    is_uncommon = False
                    break

            if is_uncommon:
                max_len = max(max_len, len(s_i))

        return max_len