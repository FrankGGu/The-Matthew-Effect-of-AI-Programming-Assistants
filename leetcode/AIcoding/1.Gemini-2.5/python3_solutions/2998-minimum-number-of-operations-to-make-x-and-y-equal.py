from collections import deque

class Solution:
    def minimumOperationsToMakeEqual(self, x: int, y: int) -> int:
        if x == y:
            return 0

        q = deque([(x, 0)])
        visited = {x}

        while q:
            current_num, ops = q.popleft()

            next_num_plus_1 = current_num + 1
            if next_num_plus_1 == y:
                return ops + 1
            if next_num_plus_1 not in visited:
                visited.add(next_num_plus_1)
                q.append((next_num_plus_1, ops + 1))

            next_num_minus_1 = current_num - 1
            if next_num_minus_1 == y:
                return ops + 1
            if next_num_minus_1 >= 0 and next_num_minus_1 not in visited:
                visited.add(next_num_minus_1)
                q.append((next_num_minus_1, ops + 1))

            if current_num % 5 == 0:
                next_num_div_5 = current_num // 5
                if next_num_div_5 == y:
                    return ops + 1
                if next_num_div_5 not in visited:
                    visited.add(next_num_div_5)
                    q.append((next_num_div_5, ops + 1))

            if current_num % 11 == 0:
                next_num_div_11 = current_num // 11
                if next_num_div_11 == y:
                    return ops + 1
                if next_num_div_11 not in visited:
                    visited.add(next_num_div_11)
                    q.append((next_num_div_11, ops + 1))

        return -1