class Solution:
    def countInversions(self, arr):
        count = 0
        def merge_sort(arr):
            nonlocal count
            if len(arr) <= 1:
                return arr
            mid = len(arr) // 2
            left = merge_sort(arr[:mid])
            right = merge_sort(arr[mid:])
            merged = []
            i = 0
            j = 0
            while i < len(left) and j < len(right):
                if left[i] <= right[j]:
                    merged.append(left[i])
                    i += 1
                else:
                    merged.append(right[j])
                    count += len(left) - i
                    j += 1
            merged += left[i:]
            merged += right[j:]
            return merged

        merge_sort(arr)
        return count