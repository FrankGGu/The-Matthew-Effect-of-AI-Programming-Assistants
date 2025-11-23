class Solution:
    def executeInstructions(self, n: int, startPos: List[int], s: str) -> List[int]:
        result = []
        directions = {'U': (-1, 0), 'D': (1, 0), 'L': (0, -1), 'R': (0, 1)}
        for i in range(len(s)):
            x, y = startPos
            count = 0
            for j in range(i, len(s)):
                dx, dy = directions[s[j]]
                x += dx
                y += dy
                if 0 <= x < n and 0 <= y < n:
                    count += 1
                else:
                    break
            result.append(count)
        return result