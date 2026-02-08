import math
from collections import deque

class Solution:
    def numSquares(self, n: int) -> int:
        square_nums = [i * i for i in range(1, int(math.sqrt(n)) + 1)]
        queue = deque()
        queue.append((n, 0))
        visited = set()
        visited.add(n)

        while queue:
            num, step = queue.popleft()
            if num == 0:
                return step
            for square in square_nums:
                if num < square:
                    break
                next_num = num - square
                if next_num not in visited:
                    queue.append((next_num, step + 1))
                    visited.add(next_num)
        return -1