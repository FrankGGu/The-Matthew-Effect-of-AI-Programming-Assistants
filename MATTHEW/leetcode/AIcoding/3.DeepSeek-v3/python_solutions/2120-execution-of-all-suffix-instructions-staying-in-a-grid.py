class Solution:
    def executeInstructions(self, n: int, startPos: List[int], s: str) -> List[int]:
        res = []
        m = len(s)
        for i in range(m):
            x, y = startPos
            count = 0
            for j in range(i, m):
                if s[j] == 'L':
                    y -= 1
                elif s[j] == 'R':
                    y += 1
                elif s[j] == 'U':
                    x -= 1
                elif s[j] == 'D':
                    x += 1
                if x < 0 or x >= n or y < 0 or y >= n:
                    break
                count += 1
            res.append(count)
        return res