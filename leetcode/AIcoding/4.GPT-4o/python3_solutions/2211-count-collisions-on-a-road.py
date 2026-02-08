class Solution:
    def countCollisions(self, directions: str) -> int:
        count = 0
        n = len(directions)

        for i in range(n):
            if directions[i] == 'S':
                continue
            if i > 0 and directions[i] == 'L' and directions[i-1] == 'R':
                count += 2
            if i < n - 1 and directions[i] == 'R' and directions[i+1] == 'L':
                count += 2

        count += directions.count('S')

        left_collisions = 0
        for i in range(n):
            if directions[i] == 'L':
                left_collisions += 1
            elif directions[i] == 'R':
                if left_collisions > 0:
                    count += left_collisions
                    left_collisions = 0

        return count