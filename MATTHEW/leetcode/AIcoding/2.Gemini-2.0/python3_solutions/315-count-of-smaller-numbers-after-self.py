class Solution:
    def countSmaller(self, nums: List[int]) -> List[int]:
        def merge_sort(arr, indices, counts):
            if len(arr) <= 1:
                return arr, indices

            mid = len(arr) // 2
            left_arr, left_indices = merge_sort(arr[:mid], indices[:mid], counts)
            right_arr, right_indices = merge_sort(arr[mid:], indices[mid:], counts)

            merged_arr = []
            merged_indices = []
            i, j = 0, 0
            while i < len(left_arr) and j < len(right_arr):
                if left_arr[i] <= right_arr[j]:
                    merged_arr.append(left_arr[i])
                    merged_indices.append(left_indices[i])
                    counts[left_indices[i]] += j
                    i += 1
                else:
                    merged_arr.append(right_arr[j])
                    merged_indices.append(right_indices[j])
                    j += 1

            while i < len(left_arr):
                merged_arr.append(left_arr[i])
                merged_indices.append(left_indices[i])
                counts[left_indices[i]] += j
                i += 1

            while j < len(right_arr):
                merged_arr.append(right_arr[j])
                merged_indices.append(right_indices[j])
                j += 1

            return merged_arr, merged_indices

        n = len(nums)
        indices = list(range(n))
        counts = [0] * n
        merge_sort(nums, indices, counts)
        return counts