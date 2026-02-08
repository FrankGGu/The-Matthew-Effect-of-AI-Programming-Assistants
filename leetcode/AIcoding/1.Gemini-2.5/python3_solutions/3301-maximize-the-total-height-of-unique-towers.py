class Solution:
    def maximumSumOfHeights(self, maxHeights: list[int]) -> int:
        n = len(maxHeights)

        left_sums = [0] * n
        stack = [] # Stores indices of elements in a strictly increasing sequence of maxHeights

        for i in range(n):
            # Pop elements from stack that are greater than or equal to maxHeights[i]
            # These elements cannot be part of the non-decreasing sequence ending at maxHeights[i]
            # with their original heights, as maxHeights[i] is smaller.
            # They will be replaced by maxHeights[i] for the segment they cover.
            while stack and maxHeights[stack[-1]] >= maxHeights[i]:
                stack.pop()

            # Determine the index of the previous element strictly smaller than maxHeights[i]
            # This 'prev_smaller_idx' defines the left boundary of the segment where maxHeights[i]
            # will be the effective height.
            prev_smaller_idx = stack[-1] if stack else -1

            # Calculate the sum for the current segment ending at i with height maxHeights[i]
            # The segment length is (i - prev_smaller_idx)
            current_segment_sum = maxHeights[i] * (i - prev_smaller_idx)

            # Add the sum from the segment to the left of prev_smaller_idx
            if prev_smaller_idx != -1:
                left_sums[i] = current_segment_sum + left_sums[prev_smaller_idx]
            else:
                left_sums[i] = current_segment_sum

            stack.append(i)

        right_sums = [0] * n
        stack = [] # Stores indices of elements in a strictly increasing sequence of maxHeights (when traversed right-to-left)

        for i in range(n - 1, -1, -1):
            # Pop elements from stack that are greater than or equal to maxHeights[i]
            while stack and maxHeights[stack[-1]] >= maxHeights[i]:
                stack.pop()

            # Determine the index of the next element strictly smaller than maxHeights[i]
            # This 'next_smaller_idx' defines the right boundary of the segment where maxHeights[i]
            # will be the effective height.
            next_smaller_idx = stack[-1] if stack else n

            # Calculate the sum for the current segment starting at i with height maxHeights[i]
            # The segment length is (next_smaller_idx - i)
            current_segment_sum = maxHeights[i] * (next_smaller_idx - i)

            # Add the sum from the segment to the right of next_smaller_idx
            if next_smaller_idx != n:
                right_sums[i] = current_segment_sum + right_sums[next_smaller_idx]
            else:
                right_sums[i] = current_segment_sum

            stack.append(i)

        max_total_height = 0
        for i in range(n):
            # For each tower 'i' considered as the peak:
            # The total height is the sum of heights from 0 to i (left_sums[i])
            # plus the sum of heights from i to n-1 (right_sums[i]).
            # Since maxHeights[i] is counted in both left_sums[i] and right_sums[i],
            # we subtract it once to get the correct total sum.
            max_total_height = max(max_total_height, left_sums[i] + right_sums[i] - maxHeights[i])

        return max_total_height