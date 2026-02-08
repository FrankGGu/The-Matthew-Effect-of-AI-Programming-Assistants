class Solution:
    def robot(self, command: str, obstacles: List[List[int]], x: int, y: int) -> bool:
        path = set()
        cx, cy = 0, 0
        path.add((0, 0))
        for c in command:
            if c == 'U':
                cy += 1
            else:
                cx += 1
            path.add((cx, cy))

        def canReach(tx, ty):
            k = min(tx // cx, ty // cy)
            tx -= k * cx
            ty -= k * cy
            return (tx, ty) in path

        if not canReach(x, y):
            return False

        for ox, oy in obstacles:
            if ox <= x and oy <= y and canReach(ox, oy):
                return False

        return True