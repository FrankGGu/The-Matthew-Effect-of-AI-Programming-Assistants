class Solution:
    def countInversions(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0

        temp = [0] * n  # Temporary array for merging

        def merge_sort_and_count(arr, temp_arr, left, right):
            if left >= right:
                return 0

            mid = (left + right) // 2

            inv_count = merge_sort_and_count(arr, temp_arr, left, mid)
            inv_count += merge_sort_and_count(arr, temp_arr, mid + 1, right)
            inv_count += merge(arr, temp_arr, left, mid, right)

            return inv_count

        def merge(arr, temp_arr, left, mid, right):
            i = left      # Pointer for left sub-array
            j = mid + 1   # Pointer for right sub-array
            k = left      # Pointer for temporary array
            inv_count = 0

            while i <= mid and j <= right:
                if arr[i] <= arr[j]:
                    temp_arr[k] = arr[i]
                    i += 1
                else:
                    temp_arr[k] = arr[j]
                    # If arr[i] > arr[j], then arr[j] forms an inversion with arr[i]
                    # and all remaining elements in the left sub-array (from arr[i] to arr[mid]).
                    inv_count += (mid - i + 1)
                    j += 1
                k += 1

            # Copy remaining elements of left sub-array, if any
            while i <= mid:
                temp_arr[k] = arr[i]
                i += 1
                k += 1

            # Copy remaining elements of right sub-array, if any
            while j <= right:
                temp_arr[k] = arr[j]
                j += 1
                k += 1

            # Copy the merged elements back to the original array
            for idx in range(left, right + 1):
                arr[idx] = temp_arr[idx]

            return inv_count

        return merge_sort_and_count(nums, temp, 0, n - 1)