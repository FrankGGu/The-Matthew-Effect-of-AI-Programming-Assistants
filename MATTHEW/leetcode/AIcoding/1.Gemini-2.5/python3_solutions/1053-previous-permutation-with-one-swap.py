class Solution:
    def prevPermutationWithOneSwap(self, arr: list[int]) -> list[int]:
        n = len(arr)

        # Step 1: Find the largest index i such that arr[i] > arr[i+1]
        # This identifies the pivot point from the right where the array is not in non-decreasing order.
        # If no such i exists, the array is already sorted in ascending order (e.g., [1, 2, 3]),
        # meaning no smaller permutation can be formed by one swap.
        i = n - 2
        while i >= 0 and arr[i] <= arr[i+1]:
            i -= 1

        if i == -1:
            # Array is sorted in ascending order, return as is.
            return arr

        # Step 2: Find the target value X to swap with arr[i].
        # X must be the largest element in the suffix arr[i+1...n-1] that is strictly less than arr[i].
        # Since arr[i+1...n-1] is in non-decreasing order (due to how i was found),
        # we can find X by iterating from right to left (n-1 down to i+1) and
        # picking the first element arr[k] that satisfies arr[k] < arr[i].

        target_val_X = -1

        for k in range(n - 1, i, -1):
            if arr[k] < arr[i]:
                target_val_X = arr[k]
                break # Found the largest value smaller than arr[i]

        # Step 3: Find the smallest index j such that arr[j] == target_val_X.
        # This ensures that among elements equal to target_val_X, we pick the leftmost one.
        # Picking the leftmost one minimizes the change in the suffix arr[i+1...n-1]
        # and thus results in a lexicographically larger permutation among those smaller than arr.

        swap_j = -1
        for k in range(i + 1, n):
            if arr[k] == target_val_X:
                swap_j = k
                break # Found the leftmost index for target_val_X

        # Step 4: Swap arr[i] and arr[swap_j]
        arr[i], arr[swap_j] = arr[swap_j], arr[i]

        return arr