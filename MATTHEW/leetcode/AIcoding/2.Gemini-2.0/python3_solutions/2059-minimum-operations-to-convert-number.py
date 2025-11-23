from collections import deque

class Solution:
    def minimumOperations(self, nums: List[int], start: int, goal: int) -> int:
        q = deque([(start, 0)])
        visited = {start}
        while q:
            curr, steps = q.popleft()
            if curr == goal:
                return steps
            for num in nums:
                next_val = curr + num
                if 0 <= next_val <= 1000 and next_val not in visited:
                    q.append((next_val, steps + 1))
                    visited.add(next_val)
                next_val = curr - num
                if 0 <= next_val <= 1000 and next_val not in visited:
                    q.append((next_val, steps + 1))
                    visited.add(next_val)
                next_val = curr ^ num
                if 0 <= next_val <= 1000 and next_val not in visited:
                    q.append((next_val, steps + 1))
                    visited.add(next_val)
        return -1