import collections
from bisect import bisect_left, bisect_right, insort_left

class Solution:
    def oddEvenJumps(self, arr: list[int]) -> int:
        n = len(arr)
        if n == 1:
            return 1

        next_higher = [-1] * n
        next_lower = [-1] * n

        # Calculate next_higher: smallest index j > i such that arr[j] >= arr[i]
        # Sort indices by value ascending, then by index ascending.
        # Use a monotonic stack to find the next greater or equal element to the right.
        stack = [] # Stores indices in decreasing order
        # The key for sorting ensures that if values are equal, smaller indices are processed first.
        # This is crucial for correctly identifying the "smallest index j".
        sorted_indices_for_higher = sorted(range(n), key=lambda x: (arr[x], x))
        for i in sorted_indices_for_higher:
            while stack and stack[-1] < i:
                next_higher[stack.pop()] = i
            stack.append(i)

        # Calculate next_lower: smallest index j > i such that arr[j] <= arr[i]
        # Sort indices by value descending, then by index ascending.
        # Use a monotonic stack to find the next smaller or equal element to the right.
        stack = [] # Stores indices in decreasing order
        # The key for sorting ensures that if values are equal, smaller indices are processed first.
        sorted_indices_for_lower = sorted(range(n), key=lambda x: (-arr[x], x))
        for i in sorted_indices_for_lower:
            while stack and stack[-1] < i:
                next_lower[stack.pop()] = i
            stack.append(i)

        # dp[i][0] indicates if we can reach the end starting from index i with an odd jump as the first jump.
        # dp[i][1] indicates if we can reach the end starting from index i with an even jump as the first jump.
        dp = [[False] * 2 for _ in range(n)]

        # Base case: From the last index, we are already at the end, so it's always possible.
        dp[n-1][0] = True
        dp[n-1][1] = True

        # Iterate backwards from n-2 to 0
        for i in range(n - 2, -1, -1):
            # For an odd jump from i:
            # We jump to next_higher[i]. From there, the next jump must be an even jump.
            if next_higher[i] != -1:
                dp[i][0] = dp[next_higher[i]][1]

            # For an even jump from i:
            # We jump to next_lower[i]. From there, the next jump must be an odd jump.
            if next_lower[i] != -1:
                dp[i][1] = dp[next_lower[i]][0]

        # Count the number of "good" starting indices.
        # A starting index is good if an odd jump from it can lead to the end.
        count = 0
        for i in range(n):
            if dp[i][0]:
                count += 1

        return count