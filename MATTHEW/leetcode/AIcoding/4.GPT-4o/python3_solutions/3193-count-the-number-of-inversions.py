class Solution:
    def countInversions(self, arr: List[int]) -> int:
        def merge_count_split_inv(arr, temp_arr, left, mid, right):
            i = left    # Starting index for left subarray
            j = mid + 1 # Starting index for right subarray
            k = left    # Starting index to be sorted
            inv_count = 0

            while i <= mid and j <= right:
                if arr[i] <= arr[j]:
                    temp_arr[k] = arr[i]
                    i += 1
                else:
                    temp_arr[k] = arr[j]
                    inv_count += (mid - i + 1)
                    j += 1
                k += 1

            while i <= mid:
                temp_arr[k] = arr[i]
                i += 1
                k += 1

            while j <= right:
                temp_arr[k] = arr[j]
                j += 1
                k += 1

            for index in range(left, right + 1):
                arr[index] = temp_arr[index]

            return inv_count

        def merge_sort_and_count(arr, temp_arr, left, right):
            inv_count = 0
            if left < right:
                mid = (left + right) // 2

                inv_count += merge_sort_and_count(arr, temp_arr, left, mid)
                inv_count += merge_sort_and_count(arr, temp_arr, mid + 1, right)
                inv_count += merge_count_split_inv(arr, temp_arr, left, mid, right)

            return inv_count

        n = len(arr)
        temp_arr = [0] * n
        return merge_sort_and_count(arr, temp_arr, 0, n - 1)