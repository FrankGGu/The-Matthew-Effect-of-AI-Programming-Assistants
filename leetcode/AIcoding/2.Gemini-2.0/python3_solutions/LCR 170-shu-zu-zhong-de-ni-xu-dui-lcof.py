class Solution:
    def reversePairs(self, nums: List[int]) -> int:
        def merge_sort(arr):
            if len(arr) <= 1:
                return arr, 0

            mid = len(arr) // 2
            left, count_left = merge_sort(arr[:mid])
            right, count_right = merge_sort(arr[mid:])

            merged = []
            i, j = 0, 0
            count = 0

            while i < len(left) and j < len(right):
                if left[i] <= right[j]:
                    merged.append(left[i])
                    i += 1
                else:
                    merged.append(right[j])
                    count += len(left) - i
                    j += 1

            merged.extend(left[i:])
            merged.extend(right[j:])

            return merged, count + count_left + count_right

        return merge_sort(nums)[1]