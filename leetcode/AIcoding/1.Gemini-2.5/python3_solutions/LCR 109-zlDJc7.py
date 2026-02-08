from collections import deque

class Solution:
    def openLock(self, deadends: list[str], target: str) -> int:
        dead_set = set(deadends)

        if "0000" in dead_set:
            return -1

        if target == "0000":
            return 0

        queue = deque([("0000", 0)])
        visited = {"0000"}

        while queue:
            current_combo, turns = queue.popleft()

            for i in range(4):
                digit = int(current_combo[i])

                # Turn up
                new_digit_up = str((digit + 1) % 10)
                new_combo_up = current_combo[:i] + new_digit_up + current_combo[i+1:]

                if new_combo_up == target:
                    return turns + 1
                if new_combo_up not in visited and new_combo_up not in dead_set:
                    visited.add(new_combo_up)
                    queue.append((new_combo_up, turns + 1))

                # Turn down
                new_digit_down = str((digit - 1 + 10) % 10)
                new_combo_down = current_combo[:i] + new_digit_down + current_combo[i+1:]

                if new_combo_down == target:
                    return turns + 1
                if new_combo_down not in visited and new_combo_down not in dead_set:
                    visited.add(new_combo_down)
                    queue.append((new_combo_down, turns + 1))

        return -1