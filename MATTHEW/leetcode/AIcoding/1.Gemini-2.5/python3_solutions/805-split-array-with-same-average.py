import collections

class Solution:
    def splitArraySameAverage(self, nums: list[int]) -> bool:
        N = len(nums)
        S = sum(nums)

        if N == 1:
            return False

        # Pre-calculate all possible sums and counts for subsets of the left half of nums
        # dp_left[k] will be a set of sums achievable using k elements from left_half
        N_L = N // 2
        left_half = nums[:N_L]

        dp_left = [set() for _ in range(N_L + 1)]
        dp_left[0].add(0) # A subset of 0 elements has a sum of 0

        for num in left_half:
            # Iterate counts downwards to ensure each number is used at most once in a subset
            for k in range(len(left_half), 0, -1):
                for s in dp_left[k-1]:
                    dp_left[k].add(s + num)

        # Pre-calculate all possible sums and counts for subsets of the right half of nums
        N_R = N - N_L
        right_half = nums[N_L:]

        dp_right = [set() for _ in range(N_R + 1)]
        dp_right[0].add(0) # A subset of 0 elements has a sum of 0

        for num in right_half:
            # Iterate counts downwards to ensure each number is used at most once in a subset
            for k in range(len(right_half), 0, -1):
                for s in dp_right[k-1]:
                    dp_right[k].add(s + num)

        # Iterate through all possible lengths k_A for subarray A
        # k_A must be between 1 and N-1 (exclusive) to ensure both A and B are non-empty
        for k_A in range(1, N):
            # The target sum for subarray A (s_A) must satisfy s_A / k_A == S / N
            # This implies s_A * N == k_A * S
            # If k_A * S is not divisible by N, then no integer s_A exists, so skip
            if (k_A * S) % N != 0:
                continue

            target_sum = (k_A * S) // N

            # Try to find a split where A's sum is target_sum and length is k_A
            # A's elements can come from left_half (k1 elements, sum s1) and right_half (k2 elements, sum s2)
            # such that k1 + k2 = k_A and s1 + s2 = target_sum
            for k1 in range(0, N_L + 1):
                k2 = k_A - k1

                # Check if k2 is a valid count for elements from right_half
                if k2 < 0 or k2 > N_R:
                    continue

                # Iterate through all sums s1 achievable with k1 elements from left_half
                for s1 in dp_left[k1]:
                    needed_s2 = target_sum - s1

                    # If needed_s2 can be formed by k2 elements from right_half, we found a valid split
                    if needed_s2 in dp_right[k2]:
                        return True

        return False