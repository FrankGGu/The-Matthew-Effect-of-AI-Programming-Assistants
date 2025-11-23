class Solution:
    def findAnagrams(self, s: str, p: str) -> list[int]:
        ns, np = len(s), len(p)
        if ns < np:
            return []

        p_count = [0] * 26
        s_count = [0] * 26

        for i in range(np):
            p_count[ord(p[i]) - ord('a')] += 1
            s_count[ord(s[i]) - ord('a')] += 1

        output = []
        if p_count == s_count:
            output.append(0)

        for i in range(ns - np):
            s_count[ord(s[i]) - ord('a')] -= 1
            s_count[ord(s[i + np]) - ord('a')] += 1
            if p_count == s_count:
                output.append(i + 1)

        return output