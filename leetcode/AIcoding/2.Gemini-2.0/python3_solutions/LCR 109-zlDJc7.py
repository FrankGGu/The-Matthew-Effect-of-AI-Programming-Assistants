from collections import deque

class Solution:
    def openLock(self, deadends: list[str], target: str) -> int:
        deadends = set(deadends)
        if "0000" in deadends:
            return -1
        q = deque([("0000", 0)])
        visited = {"0000"}
        while q:
            lock, steps = q.popleft()
            if lock == target:
                return steps
            for i in range(4):
                digit = int(lock[i])
                for diff in [-1, 1]:
                    new_digit = (digit + diff) % 10
                    new_lock = lock[:i] + str(new_digit) + lock[i+1:]
                    if new_lock not in deadends and new_lock not in visited:
                        q.append((new_lock, steps + 1))
                        visited.add(new_lock)
        return -1