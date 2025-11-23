class Solution:
    def isPathCrossing(self, path: str) -> bool:
        visited = set()
        x, y = 0, 0
        visited.add((x, y))
        for move in path:
            if move == 'u':
                y += 1
            elif move == 'd':
                y -= 1
            elif move == 'r':
                x += 1
            elif move == 'l':
                x -= 1
            if (x, y) in visited:
                return True
            visited.add((x, y))
        return False