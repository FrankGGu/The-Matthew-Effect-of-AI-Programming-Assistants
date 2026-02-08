from collections import deque

class Solution:
    def openLock(self, deadends: list[str], target: str) -> int:
        dead = set(deadends)
        if "0000" in dead:
            return -1

        q = deque([("0000", 0)])
        visited = {"0000"}

        while q:
            lock, moves = q.popleft()

            if lock == target:
                return moves

            for i in range(4):
                digit = int(lock[i])

                up = lock[:i] + str((digit + 1) % 10) + lock[i+1:]
                down = lock[:i] + str((digit - 1) % 10) + lock[i+1:]

                if up not in dead and up not in visited:
                    q.append((up, moves + 1))
                    visited.add(up)

                if down not in dead and down not in visited:
                    q.append((down, moves + 1))
                    visited.add(down)

        return -1