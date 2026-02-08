class Solution:
    def maximumSumOfHeights(self, maxHeights: list[int]) -> int:
        n = len(maxHeights)
        max_total_height = 0

        for p in range(n):
            current_sum = 0

            current_height_left = maxHeights[p]
            current_sum += current_height_left
            for i in range(p - 1, -1, -1):
                current_height_left = min(maxHeights[i], current_height_left)
                current_sum += current_height_left

            current_height_right = maxHeights[p]
            for i in range(p + 1, n):
                current_height_right = min(maxHeights[i], current_height_right)
                current_sum += current_height_right

            max_total_height = max(max_total_height, current_sum)

        return max_total_height