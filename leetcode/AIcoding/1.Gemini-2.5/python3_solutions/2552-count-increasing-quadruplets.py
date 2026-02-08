class Solution:
    def countIncreasingQuadruplets(self, nums: list[int]) -> int:
        n = len(nums)
        ans = 0

        # left_less_than_curr[j][val] = count of i < j such that nums[i] < val
        # val ranges from 0 to n. Array size n+1.
        # nums[i] values are 1-indexed, so we use val_idx 0 to n.
        left_less_than_curr = [[0] * (n + 1) for _ in range(n)]

        counts_before_j = [0] * (n + 1) # counts of values seen before index j
        for j in range(n):
            # Populate left_less_than_curr[j]
            # left_less_than_curr[j][val_idx] is the sum of counts_before_j[v] for v < val_idx
            current_sum = 0
            for val_idx in range(n + 1): # val_idx from 0 to n
                left_less_than_curr[j][val_idx] = current_sum
                current_sum += counts_before_j[val_idx]

            # Update counts_before_j for the next iteration (j+1)
            counts_before_j[nums[j]] += 1

        # right_greater_than_curr[k][val] = count of l > k such that nums[l] > val
        # val ranges from 0 to n. Array size n+1.
        right_greater_than_curr = [[0] * (n + 1) for _ in range(n)]

        counts_after_k = [0] * (n + 1) # counts of values seen after index k
        for k in range(n - 1, -1, -1):
            # Populate right_greater_than_curr[k]
            # right_greater_than_curr[k][val_idx] is the sum of counts_after_k[v] for v > val_idx
            current_sum = 0
            for val_idx in range(n, -1, -1): # val_idx from n down to 0
                right_greater_than_curr[k][val_idx] = current_sum
                current_sum += counts_after_k[val_idx]

            # Update counts_after_k for the next iteration (k-1)
            counts_after_k[nums[k]] += 1

        # Main loop to count quadruplets (i, j, k, l)
        # 0 <= i < j < k < l < n
        # nums[i] < nums[l]
        # nums[j] > nums[k]
        for j in range(n):
            for k in range(j + 1, n):
                if nums[j] > nums[k]:
                    # For fixed j and k satisfying nums[j] > nums[k],
                    # we need to count pairs (i, l) such that:
                    # i < j
                    # l > k
                    # nums[i] < nums[l]

                    # This can be computed by summing over all possible values 'x' for nums[i]:
                    # sum_{x=1 to n} (count of i<j with nums[i]=x) * (count of l>k with nums[l]>x)

                    current_pair_count = 0
                    for x in range(1, n + 1): # Iterate through all possible values for nums[i] (1 to n)
                        # Count of i < j such that nums[i] == x
                        # This is (count of i<j with nums[i]<x+1) - (count of i<j with nums[i]<x)
                        count_i_eq_x = left_less_than_curr[j][x+1] - left_less_than_curr[j][x]

                        # Count of l > k such that nums[l] > x
                        count_l_gt_x = right_greater_than_curr[k][x]

                        current_pair_count += count_i_eq_x * count_l_gt_x
                    ans += current_pair_count

        return ans