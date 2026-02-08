class Solution:
    def longestWPI(self, hours: list[int]) -> int:
        prefix_sum = 0
        # Stores the first occurrence of each prefix sum value.
        # {prefix_sum_value: index}
        # Initialize with 0 at index -1 to handle intervals starting from index 0.
        first_occurrence = {0: -1}
        max_len = 0

        for i, h in enumerate(hours):
            # Assign score: +1 for tiring day (hours > 8), -1 for non-tiring day (hours <= 8)
            score = 1 if h > 8 else -1
            prefix_sum += score

            # Case 1: The current prefix_sum is positive.
            # This means the interval from index 0 to i is well-performing.
            # Its length is i + 1.
            if prefix_sum > 0:
                max_len = max(max_len, i + 1)
            # Case 2: The current prefix_sum is not positive.
            # We need to find a previous index 'k' such that prefix_sum[i] - prefix_sum[k] > 0.
            # This means prefix_sum[k] < prefix_sum[i].
            # To maximize the length (i - k), we need to find the smallest 'k'.
            # The key insight for this problem is that we only need to check for prefix_sum[k] = prefix_sum[i] - 1.
            # If prefix_sum - 1 has been seen before, calculate the length of that interval.
            elif prefix_sum - 1 in first_occurrence:
                max_len = max(max_len, i - first_occurrence[prefix_sum - 1])

            # If the current prefix_sum is encountered for the first time, store its index.
            # We only care about the *first* occurrence to maximize the interval length.
            if prefix_sum not in first_occurrence:
                first_occurrence[prefix_sum] = i

        return max_len