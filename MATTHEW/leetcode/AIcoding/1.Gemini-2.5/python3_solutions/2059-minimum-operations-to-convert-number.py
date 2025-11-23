import collections

class Solution:
    def minimumOperations(self, nums: list[int], start: int, target: int) -> int:
        if start == target:
            return 0

        queue = collections.deque([(start, 0)])
        visited = {start}

        while queue:
            curr_num, steps = queue.popleft()

            for num_op in nums:
                # Operation 1: addition
                next_num_add = curr_num + num_op
                if next_num_add == target:
                    return steps + 1
                if 0 <= next_num_add <= 1000 and next_num_add not in visited:
                    visited.add(next_num_add)
                    queue.append((next_num_add, steps + 1))

                # Operation 2: subtraction
                next_num_sub = curr_num - num_op
                if next_num_sub == target:
                    return steps + 1
                if 0 <= next_num_sub <= 1000 and next_num_sub not in visited:
                    visited.add(next_num_sub)
                    queue.append((next_num_sub, steps + 1))

                # Operation 3: XOR
                next_num_xor = curr_num ^ num_op
                if next_num_xor == target:
                    return steps + 1
                if 0 <= next_num_xor <= 1000 and next_num_xor not in visited:
                    visited.add(next_num_xor)
                    queue.append((next_num_xor, steps + 1))

        return -1