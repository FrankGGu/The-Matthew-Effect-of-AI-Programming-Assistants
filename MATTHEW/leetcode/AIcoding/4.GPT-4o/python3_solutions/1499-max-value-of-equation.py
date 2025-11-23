class Solution:
    def findMaxValueOfEquation(self, points: List[List[int]], k: int) -> int:
        max_value = float('-inf')
        deque = collections.deque()

        for x, y in points:
            while deque and x - deque[0][0] > k:
                deque.popleft()
            if deque:
                max_value = max(max_value, y + x + deque[0][1] - deque[0][0])
            while deque and deque[-1][1] - deque[-1][0] <= y - x:
                deque.pop()
            deque.append((x, y))

        return max_value