class Solution:
    def minimumOperations(self, nums: List[int], start: int, goal: int) -> int:
        from collections import deque

        visited = set()
        q = deque()
        q.append((start, 0))
        visited.add(start)

        while q:
            current, steps = q.popleft()
            if current == goal:
                return steps
            if current < 0 or current > 1000:
                continue
            for num in nums:
                for next_num in [current + num, current - num, current ^ num]:
                    if next_num == goal:
                        return steps + 1
                    if 0 <= next_num <= 1000 and next_num not in visited:
                        visited.add(next_num)
                        q.append((next_num, steps + 1))
        return -1