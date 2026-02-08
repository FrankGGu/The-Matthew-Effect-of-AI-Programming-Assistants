class Solution:
    def canForm(self, s: str, t: str, x: str) -> bool:
        n, m, p = len(s), len(t), len(x)
        if n + m != p:
            return False

        s_count = [0] * 26
        t_count = [0] * 26
        x_count = [0] * 26

        for char in s:
            s_count[ord(char) - ord('a')] += 1
        for char in t:
            t_count[ord(char) - ord('a')] += 1
        for char in x:
            x_count[ord(char) - ord('a')] += 1

        for i in range(26):
            if s_count[i] + t_count[i] < x_count[i]:
                return False

        return True

    def checkString(self, s: str, t: str, x: str) -> bool:
        return self.canForm(s, t, x)