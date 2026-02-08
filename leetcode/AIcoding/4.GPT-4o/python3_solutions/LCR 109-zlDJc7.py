from collections import deque

class Solution:
    def openLock(self, deadends: List[str], target: str) -> int:
        dead_set = set(deadends)
        if "0000" in dead_set:
            return -1
        if target == "0000":
            return 0

        queue = deque([("0000", 0)])
        visited = set("0000")

        while queue:
            curr, steps = queue.popleft()
            for i in range(4):
                for move in [-1, 1]:
                    next_lock = list(curr)
                    next_lock[i] = str((int(curr[i]) + move) % 10)
                    next_lock = ''.join(next_lock)
                    if next_lock == target:
                        return steps + 1
                    if next_lock not in visited and next_lock not in dead_set:
                        visited.add(next_lock)
                        queue.append((next_lock, steps + 1))
        return -1