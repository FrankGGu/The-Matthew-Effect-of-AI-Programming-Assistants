class Solution:
    def countInversions(self, arr):
        if len(arr) <= 1:
            return 0
        temp = [0] * len(arr)
        return self.merge_sort(arr, temp, 0, len(arr) - 1)

    def merge_sort(self, arr, temp, left, right):
        inv_count = 0
        if left < right:
            mid = (left + right) // 2
            inv_count += self.merge_sort(arr, temp, left, mid)
            inv_count += self.merge_sort(arr, temp, mid + 1, right)
            inv_count += self.merge(arr, temp, left, mid, right)
        return inv_count

    def merge(self, arr, temp, left, mid, right):
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
            k += 1
            i += 1

        while j <= right:
            temp[k] = arr[j]
            k += 1
            j += 1

        for idx in range(left, right + 1):
            arr[idx] = temp[idx]

        return inv_count