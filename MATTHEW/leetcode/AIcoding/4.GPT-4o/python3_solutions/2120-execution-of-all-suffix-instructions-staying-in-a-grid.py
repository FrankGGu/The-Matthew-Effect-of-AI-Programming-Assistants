class Solution:
    def executeInstructions(self, n: int, startPos: List[int], s: str) -> List[int]:
        res = []
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        for i in range(len(s)):
            x, y = startPos
            count = 0
            for j in range(i, len(s)):
                if s[j] == 'R':
                    direction = 0
                elif s[j] == 'D':
                    direction = 1
                elif s[j] == 'L':
                    direction = 2
                else:
                    direction = 3

                x += directions[direction][0]
                y += directions[direction][1]

                if 0 <= x < n and 0 <= y < n:
                    count += 1
                else:
                    break
            res.append(count)

        return res