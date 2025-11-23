class Solution:
    def maximumSumOfHeights(self, maxHeights: list[int]) -> int:
        n = len(maxHeights)

        left_sums = [0] * n
        stack = [] # Stores (index, height, sum_up_to_index)

        for i in range(n):
            h = maxHeights[i]

            while stack and stack[-1][1] >= h:
                stack.pop()

            if not stack:
                left_sums[i] = h * (i + 1)
            else:
                prev_idx, _, prev_sum = stack[-1]
                left_sums[i] = prev_sum + h * (i - prev_idx)

            stack.append((i, h, left_sums[i]))

        right_sums = [0] * n
        stack = [] # Stores (index, height, sum_up_to_index)

        for i in range(n - 1, -1, -1):
            h = maxHeights[i]

            while stack and stack[-1][1] >= h:
                stack.pop()

            if not stack:
                right_sums[i] = h * (n - i)
            else:
                next_idx, _, next_sum = stack[-1]
                right_sums[i] = next_sum + h * (next_idx - i)

            stack.append((i, h, right_sums[i]))

        max_total_sum = 0
        for i in range(n):
            max_total_sum = max(max_total_sum, left_sums[i] + right_sums[i] - maxHeights[i])

        return max_total_sum