class Solution:
    def checkEquality(self, s: str) -> bool:
        n = len(s)
        a = []
        b = []
        for i in range(n):
            if s[i].isdigit():
                a.append(int(s[i]))
            else:
                b.append(s[i])

        a.sort()
        b.sort()

        a_str = "".join(map(str, a))
        b_str = "".join(b)

        return a_str == b_str