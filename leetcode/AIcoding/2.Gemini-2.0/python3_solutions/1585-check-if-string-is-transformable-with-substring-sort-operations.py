class Solution:
    def isTransformable(self, s: str, t: str) -> bool:
        pos = [[] for _ in range(10)]
        for i, c in enumerate(s):
            pos[int(c)].append(i)

        idx = [0] * 10

        for c in t:
            digit = int(c)
            if idx[digit] >= len(pos[digit]):
                return False

            for i in range(digit):
                if idx[i] < len(pos[i]) and pos[i][idx[i]] < pos[digit][idx[digit]]:
                    return False

            idx[digit] += 1

        return True