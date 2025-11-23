class Solution:
    def countSmaller(self, nums: list[int]) -> list[int]:
        n = len(nums)
        self.counts = [0] * n

        indexed_nums = [(nums[i], i) for i in range(n)]

        self._merge_sort(indexed_nums)

        return self.counts

    def _merge_sort(self, indexed_arr: list[tuple[int, int]]) -> list[tuple[int, int]]:
        if len(indexed_arr) <= 1:
            return indexed_arr

        mid = len(indexed_arr) // 2
        left_half = self._merge_sort(indexed_arr[:mid])
        right_half = self._merge_sort(indexed_arr[mid:])

        merged = []
        i, j = 0, 0
        right_count = 0

        while i < len(left_half) and j < len(right_half):
            if left_half[i][0] <= right_half[j][0]:
                self.counts[left_half[i][1]] += right_count
                merged.append(left_half[i])
                i += 1
            else:
                merged.append(right_half[j])
                right_count += 1
                j += 1

        while i < len(left_half):
            self.counts[left_half[i][1]] += right_count
            merged.append(left_half[i])
            i += 1

        while j < len(right_half):
            merged.append(right_half[j])
            j += 1

        return merged