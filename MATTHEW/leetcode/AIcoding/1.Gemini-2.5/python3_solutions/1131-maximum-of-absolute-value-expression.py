class Solution:
    def maxAbsValExpr(self, arr1: list[int], arr2: list[int]) -> int:
        n = len(arr1)
        max_val = 0

        # Iterate over all 8 combinations of signs for s1, s2, s3
        for s1 in [-1, 1]:
            for s2 in [-1, 1]:
                for s3 in [-1, 1]:
                    current_min_sum = float('inf')
                    current_max_sum = float('-inf')

                    for k in range(n):
                        # Calculate the value for the current combination of signs and index k
                        current_sum = s1 * arr1[k] + s2 * arr2[k] + s3 * k

                        current_min_sum = min(current_min_sum, current_sum)
                        current_max_sum = max(current_max_sum, current_sum)

                    # Update the overall maximum absolute difference
                    max_val = max(max_val, current_max_sum - current_min_sum)

        return max_val