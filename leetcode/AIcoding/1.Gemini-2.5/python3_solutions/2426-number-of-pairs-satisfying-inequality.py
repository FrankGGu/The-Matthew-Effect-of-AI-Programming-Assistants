class Solution:
    def numberOfPairs(self, nums1: list[int], nums2: list[int], diff: int) -> int:
        n = len(nums1)
        arr = [nums1[i] - nums2[i] for i in range(n)]

        self.count = 0

        def merge_sort(sub_arr):
            if len(sub_arr) <= 1:
                return sub_arr

            mid = len(sub_arr) // 2
            left_half = merge_sort(sub_arr[:mid])
            right_half = merge_sort(sub_arr[mid:])

            # Counting step for pairs (i, j) where i is in left_half and j is in right_half
            p1 = 0  # Pointer for left_half
            p2 = 0  # Pointer for right_half
            while p1 < len(left_half) and p2 < len(right_half):
                if left_half[p1] <= right_half[p2] + diff:
                    # If left_half[p1] satisfies the condition with right_half[p2],
                    # it will also satisfy with all elements from right_half[p2] to the end,
                    # because right_half is sorted.
                    self.count += (len(right_half) - p2)
                    p1 += 1
                else:
                    # If left_half[p1] is too large for right_half[p2],
                    # we need a larger element from right_half.
                    p2 += 1

            # Standard merge step to sort the combined array
            merged_arr = []
            p1 = 0
            p2 = 0
            while p1 < len(left_half) and p2 < len(right_half):
                if left_half[p1] <= right_half[p2]:
                    merged_arr.append(left_half[p1])
                    p1 += 1
                else:
                    merged_arr.append(right_half[p2])
                    p2 += 1

            merged_arr.extend(left_half[p1:])
            merged_arr.extend(right_half[p2:])

            return merged_arr

        merge_sort(arr)
        return self.count