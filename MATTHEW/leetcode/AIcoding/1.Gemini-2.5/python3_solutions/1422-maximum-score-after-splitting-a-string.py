class Solution:
    def maxScore(self, s: str) -> int:
        n = len(s)

        # Calculate initial total number of ones in the entire string
        total_ones = 0
        for char in s:
            if char == '1':
                total_ones += 1

        max_score = 0
        zeros_left = 0
        ones_left = 0

        # Iterate through all possible split points
        # The split point 'i' means s[0...i] is the left part and s[i+1...n-1] is the right part.
        # 'i' can range from 0 to n-2, as both parts must be non-empty.
        for i in range(n - 1):
            if s[i] == '0':
                zeros_left += 1
            else: # s[i] == '1'
                ones_left += 1

            # Number of ones in the right part is total_ones - ones_left
            ones_right = total_ones - ones_left

            current_score = zeros_left + ones_right
            max_score = max(max_score, current_score)

        return max_score