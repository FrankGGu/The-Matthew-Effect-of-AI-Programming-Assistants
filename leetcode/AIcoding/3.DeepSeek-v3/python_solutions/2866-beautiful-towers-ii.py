class Solution:
    def maximumSumOfHeights(self, maxHeights: List[int]) -> int:
        n = len(maxHeights)
        left = [0] * n
        stack = []
        total = 0
        for i in range(n):
            while stack and maxHeights[stack[-1]] > maxHeights[i]:
                j = stack.pop()
                left_j = stack[-1] if stack else -1
                total -= (j - left_j) * maxHeights[j]
            left_i = stack[-1] if stack else -1
            total += (i - left_i) * maxHeights[i]
            left[i] = total
            stack.append(i)

        right = [0] * n
        stack = []
        total = 0
        for i in range(n-1, -1, -1):
            while stack and maxHeights[stack[-1]] > maxHeights[i]:
                j = stack.pop()
                right_j = stack[-1] if stack else n
                total -= (right_j - j) * maxHeights[j]
            right_i = stack[-1] if stack else n
            total += (right_i - i) * maxHeights[i]
            right[i] = total
            stack.append(i)

        max_sum = 0
        for i in range(n):
            current_sum = left[i] + right[i] - maxHeights[i]
            if current_sum > max_sum:
                max_sum = current_sum
        return max_sum