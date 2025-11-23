class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        s_len = len(s)
        p_len = len(p)

        prev_row = [False] * (p_len + 1)

        prev_row[0] = True

        for j in range(1, p_len + 1):
            if p[j - 1] == '*':
                prev_row[j] = prev_row[j - 1]

        for i in range(1, s_len + 1):
            curr_row = [False] * (p_len + 1)

            for j in range(1, p_len + 1):
                if p[j - 1] == s[i - 1] or p[j - 1] == '?':
                    curr_row[j] = prev_row[j - 1]
                elif p[j - 1] == '*':
                    curr_row[j] = curr_row[j - 1] or prev_row[j]

            prev_row = curr_row

        return prev_row[p_len]