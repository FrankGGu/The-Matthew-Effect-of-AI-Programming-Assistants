class Solution:
    def countSubstrings(self, s: str, t: str) -> int:
        s_len = len(s)
        t_len = len(t)
        count = 0

        for i in range(s_len):
            for j in range(t_len):
                diff = 0
                for k in range(min(s_len - i, t_len - j)):
                    if s[i + k] != t[j + k]:
                        diff += 1

                    if diff == 1:
                        count += 1

                    if diff > 1:
                        break

        return count