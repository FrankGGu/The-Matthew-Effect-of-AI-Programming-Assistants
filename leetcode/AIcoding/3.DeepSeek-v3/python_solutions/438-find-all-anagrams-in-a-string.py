from collections import defaultdict

class Solution:
    def findAnagrams(self, s: str, p: str) -> List[int]:
        if len(s) < len(p):
            return []

        p_count = defaultdict(int)
        s_count = defaultdict(int)

        for char in p:
            p_count[char] += 1

        result = []
        for i in range(len(s)):
            s_count[s[i]] += 1

            if i >= len(p):
                left_char = s[i - len(p)]
                if s_count[left_char] == 1:
                    del s_count[left_char]
                else:
                    s_count[left_char] -= 1

            if s_count == p_count:
                result.append(i - len(p) + 1)

        return result