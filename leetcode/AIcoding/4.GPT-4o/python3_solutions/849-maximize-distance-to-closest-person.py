class Solution:
    def maxDistToClosest(self, seats: List[int]) -> int:
        n = len(seats)
        left = [-1] * n
        right = [-1] * n

        for i in range(n):
            if seats[i] == 1:
                left[i] = i
            else:
                left[i] = left[i - 1] if i > 0 else -1

        for i in range(n - 1, -1, -1):
            if seats[i] == 1:
                right[i] = i
            else:
                right[i] = right[i + 1] if i < n - 1 else -1

        max_distance = 0

        for i in range(n):
            if seats[i] == 0:
                left_distance = i - left[i] if left[i] != -1 else float('inf')
                right_distance = right[i] - i if right[i] != -1 else float('inf')
                max_distance = max(max_distance, min(left_distance, right_distance))

        return max_distance