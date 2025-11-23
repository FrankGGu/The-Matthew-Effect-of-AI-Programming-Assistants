class Solution:
    def maxCandies(self, boxes, nowhere, grid):
        from collections import deque

        visited = set()
        have = set()
        queue = deque()

        for i in range(len(boxes)):
            if boxes[i] == 0:
                queue.append(i)
                visited.add(i)

        while queue:
            box = queue.popleft()
            have.add(box)
            for key in grid[box]:
                if key not in have and key in nowhere:
                    queue.append(key)
                    visited.add(key)

        return len(have)