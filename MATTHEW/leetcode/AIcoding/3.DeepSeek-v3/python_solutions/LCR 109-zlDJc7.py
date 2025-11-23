from collections import deque

class Solution:
    def openLock(self, deadends: List[str], target: str) -> int:
        dead = set(deadends)
        if "0000" in dead:
            return -1
        if target == "0000":
            return 0

        queue = deque([("0000", 0)])
        visited = set(["0000"])

        while queue:
            current, steps = queue.popleft()
            for i in range(4):
                for delta in [-1, 1]:
                    new_digit = (int(current[i]) + delta) % 10
                    new_state = current[:i] + str(new_digit) + current[i+1:
                    if new_state == target:
                        return steps + 1
                    if new_state not in dead and new_state not in visited:
                        visited.add(new_state)
                        queue.append((new_state, steps + 1))
        return -1