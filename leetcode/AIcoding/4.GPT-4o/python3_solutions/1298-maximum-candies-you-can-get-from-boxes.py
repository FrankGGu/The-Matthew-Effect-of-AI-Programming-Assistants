class Solution:
    def maxCandies(self, boxes: List[List[int]], initialBoxes: int, maxCandies: int) -> int:
        from collections import deque

        total_candies = 0
        visited = [False] * len(boxes)
        queue = deque()

        queue.append(initialBoxes)

        while queue:
            current_box = queue.popleft()
            if visited[current_box]:
                continue

            visited[current_box] = True
            total_candies += boxes[current_box][0]

            for b in boxes[current_box][1:]:
                if not visited[b]:
                    queue.append(b)

        return min(total_candies, maxCandies)