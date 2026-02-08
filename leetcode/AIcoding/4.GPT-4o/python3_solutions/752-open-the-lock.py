from collections import deque

class Solution:
    def openLock(self, deadends: List[str], target: str) -> int:
        dead = set(deadends)
        if "0000" in dead:
            return -1

        queue = deque([("0000", 0)])
        visited = {"0000"}

        while queue:
            current, steps = queue.popleft()
            if current == target:
                return steps

            for i in range(4):
                for move in [-1, 1]:
                    next_digit = (int(current[i]) + move) % 10
                    next_lock = current[:i] + str(next_digit) + current[i+1:]
                    if next_lock not in visited and next_lock not in dead:
                        visited.add(next_lock)
                        queue.append((next_lock, steps + 1))

        return -1