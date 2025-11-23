from collections import deque

class Solution:
    def minimumOperationsToMakeEqual(self, x: int, y: int) -> int:
        if x == y:
            return 0
        queue = deque()
        queue.append((x, 0))
        visited = set()
        visited.add(x)

        while queue:
            current, steps = queue.popleft()

            if current == y:
                return steps

            next_steps = steps + 1
            # Option 1: Subtract 1
            next_val = current - 1
            if next_val == y:
                return next_steps
            if next_val > 0 and next_val not in visited:
                visited.add(next_val)
                queue.append((next_val, next_steps))

            # Option 2: Add 1
            next_val = current + 1
            if next_val == y:
                return next_steps
            if next_val <= 10000 and next_val not in visited:
                visited.add(next_val)
                queue.append((next_val, next_steps))

            # Option 3: Divide by 5 if divisible
            if current % 5 == 0:
                next_val = current // 5
                if next_val == y:
                    return next_steps
                if next_val > 0 and next_val not in visited:
                    visited.add(next_val)
                    queue.append((next_val, next_steps))

            # Option 4: Divide by 11 if divisible
            if current % 11 == 0:
                next_val = current // 11
                if next_val == y:
                    return next_steps
                if next_val > 0 and next_val not in visited:
                    visited.add(next_val)
                    queue.append((next_val, next_steps))

        return -1