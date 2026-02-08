class Solution:
    def maxScoreSightseeingPair(self, A: List[int]) -> int:
        n = len(A)

        # max_A_i_plus_i stores the maximum value of A[k] + k encountered so far for k < current_j.
        # Initialize with the first element (k=0)
        max_A_i_plus_i = A[0] + 0 

        # Initialize max_score to a very small number, as scores can potentially be negative.
        # Since n >= 2, max_score will be updated at least once.
        max_score = float('-inf')

        # Iterate j from 1 to n-1 (since i < j, j must start from 1)
        for j in range(1, n):
            # Calculate the score for the current j, using the best i (represented by max_A_i_plus_i)
            # The expression is (A[i] + i) + (A[j] - j)
            current_score = max_A_i_plus_i + (A[j] - j)

            # Update the overall maximum score found
            max_score = max(max_score, current_score)

            # Update max_A_i_plus_i for the next iteration.
            # The current j becomes a potential i for subsequent j' values.
            max_A_i_plus_i = max(max_A_i_plus_i, A[j] + j)

        return max_score