class Solution:
    def alphabetBoardPath(self, target: str) -> str:
        pos = {chr(i + ord('a')): (i // 5, i % 5) for i in range(26)}
        result = []
        x, y = 0, 0

        for char in target:
            tx, ty = pos[char]
            if tx < x: result.append('U' * (x - tx))
            if ty < y: result.append('L' * (y - ty))
            if tx > x: result.append('D' * (tx - x))
            if ty > y: result.append('R' * (ty - y))
            result.append('!')
            x, y = tx, ty

        return ''.join(result)