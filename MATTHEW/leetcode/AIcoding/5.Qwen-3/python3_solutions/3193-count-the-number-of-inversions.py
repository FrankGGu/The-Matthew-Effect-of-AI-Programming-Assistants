class Solution:
    def reversePairs(self, nums):
        def merge_sort(arr, temp, left, right):
            if left >= right:
                return 0
            mid = (left + right) // 2
            inv_count = merge_sort(arr, temp, left, mid)
            inv_count += merge_sort(arr, temp, mid + 1, right)
            inv_count += merge(arr, temp, left, mid, right)
            return inv_count

        def merge(arr, temp, left, mid, right):
            i = left
            j = mid + 1
            k = left
            inv_count = 0
            while i <= mid and j <= right:
                if arr[i] <= arr[j]:
                    temp[k] = arr[i]
                    i += 1
                else:
                    temp[k] = arr[j]
                    inv_count += (mid - i + 1)
                    j += 1
                k += 1
            while i <= mid:
                temp[k] = arr[i]
                i += 1
                k += 1
            while j <= right:
                temp[k] = arr[j]
                j += 1
                k += 1
            for idx in range(left, right + 1):
                arr[idx] = temp[idx]
            return inv_count

        temp = [0] * len(nums)
        return merge_sort(nums, temp, 0, len(nums) - 1)