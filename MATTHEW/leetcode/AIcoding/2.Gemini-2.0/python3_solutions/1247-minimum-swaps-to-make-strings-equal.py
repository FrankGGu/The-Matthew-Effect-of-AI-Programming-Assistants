class Solution:
    def minimumSwaps(self, s1: str, s2: str) -> int:
        xy = 0
        yx = 0
        for i in range(len(s1)):
            if s1[i] == 'x' and s2[i] == 'y':
                xy += 1
            elif s1[i] == 'y' and s2[i] == 'x':
                yx += 1

        if (xy + yx) % 2 != 0:
            return -1

        return xy // 2 + yx // 2 + xy % 2 + yx % 2