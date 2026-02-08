class Solution:
    def sortArray(self, nums: list[int]) -> list[int]:
        def merge_sort(arr):
            if len(arr) <= 1:
                return arr

            mid = len(arr) // 2
            left_half = arr[:mid]
            right_half = arr[mid:]

            left_sorted = merge_sort(left_half)
            right_sorted = merge_sort(right_half)

            return merge(left_sorted, right_sorted)

        def merge(left, right):
            merged = []
            i = 0
            j = 0

            while i < len(left) and j < len(right):
                if left[i] <= right[j]:
                    merged.append(left[i])
                    i += 1
                else:
                    merged.append(right[j])
                    j += 1

            merged.extend(left[i:])
            merged.extend(right[j:])
            return merged

        return merge_sort(nums)