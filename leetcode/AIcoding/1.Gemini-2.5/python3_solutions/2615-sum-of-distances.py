from collections import defaultdict

class Solution:
    def sumOfDistances(self, nums: list[int]) -> list[int]:
        val_to_indices = defaultdict(list)
        for i, num in enumerate(nums):
            val_to_indices[num].append(i)

        n = len(nums)
        ans = [0] * n

        for indices in val_to_indices.values():
            k = len(indices)
            if k == 1:
                continue

            # Calculate prefix sums for the indices list
            # P_sum[j] will store sum of indices[0]...indices[j-1]
            P_sum = [0] * (k + 1)
            for j in range(k):
                P_sum[j+1] = P_sum[j] + indices[j]

            for m in range(k):
                current_p = indices[m]

                # Sum of indices to the left: indices[0]...indices[m-1]
                left_sum = P_sum[m]

                # Number of elements to the left
                left_count = m

                # Sum of indices to the right: indices[m+1]...indices[k-1]
                # P_sum[k] is total sum of all indices
                # P_sum[m+1] is sum of indices[0]...indices[m]
                right_sum = P_sum[k] - P_sum[m+1]

                # Number of elements to the right
                right_count = k - 1 - m

                # Calculate sum of distances for current_p
                # (current_p - indices[0]) + ... + (current_p - indices[m-1])
                # + (indices[m+1] - current_p) + ... + (indices[k-1] - current_p)

                # left part: left_count * current_p - left_sum
                # right part: right_sum - right_count * current_p

                ans[current_p] = (left_count * current_p - left_sum) + \
                                 (right_sum - right_count * current_p)

        return ans