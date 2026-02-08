class Solution:
    def minimumOperations(self, nums: List[int], start: int, goal: int) -> int:
        q = collections.deque([(start, 0)])
        visited = {start}

        while q:
            curr, steps = q.popleft()

            if curr == goal:
                return steps

            for num in nums:
                next_val = [curr + num, curr - num, curr ^ num]
                for v in next_val:
                    if 0 <= v <= 1000 and v not in visited:
                        q.append((v, steps + 1))
                        visited.add(v)

        return -1