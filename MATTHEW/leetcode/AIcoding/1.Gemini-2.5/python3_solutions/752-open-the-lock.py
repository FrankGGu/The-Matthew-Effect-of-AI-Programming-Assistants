import collections

class Solution:
    def openLock(self, deadends: list[str], target: str) -> int:
        dead_set = set(deadends)

        if "0000" in dead_set:
            return -1

        queue = collections.deque([("0000", 0)])
        visited = {"0000"}

        def get_neighbors(combo: str) -> list[str]:
            neighbors = []
            for i in range(4):
                digit = int(combo[i])

                # Turn up
                new_digit_up = str((digit + 1) % 10)
                neighbors.append(combo[:i] + new_digit_up + combo[i+1:])

                # Turn down
                new_digit_down = str((digit - 1 + 10) % 10)
                neighbors.append(combo[:i] + new_digit_down + combo[i+1:])
            return neighbors

        while queue:
            current_combo, steps = queue.popleft()

            if current_combo == target:
                return steps

            for next_combo in get_neighbors(current_combo):
                if next_combo not in visited and next_combo not in dead_set:
                    visited.add(next_combo)
                    queue.append((next_combo, steps + 1))

        return -1