class Solution:
    def countCollisions(self, directions: str) -> int:
        l, r = 0, len(directions) - 1
        while l < len(directions) and directions[l] == 'L':
            l += 1
        while r >= 0 and directions[r] == 'R':
            r -= 1
        collisions = 0
        for i in range(l, r + 1):
            if directions[i] != 'S':
                collisions += 1
        return collisions