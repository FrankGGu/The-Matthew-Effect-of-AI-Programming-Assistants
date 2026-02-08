class Solution:
    def reversePairs(self, nums: list[int]) -> int:
        if not nums:
            return 0

        self.count = 0
        self._merge_sort(nums, 0, len(nums) - 1)
        return self.count

    def _merge_sort(self, arr: list[int], low: int, high: int) -> None:
        if low >= high:
            return

        mid = low + (high - low) // 2
        self._merge_sort(arr, low, mid)
        self._merge_sort(arr, mid + 1, high)
        self._merge_and_count(arr, low, mid, high)

    def _merge_and_count(self, arr: list[int], low: int, mid: int, high: int) -> None:
        j = mid + 1
        for i in range(low, mid + 1):
            while j <= high and arr[i] > 2 * arr[j]:
                j += 1
            self.count += (j - (mid + 1))

        temp = []
        p1 = low
        p2 = mid + 1
        while p1 <= mid and p2 <= high:
            if arr[p1] <= arr[p2]:
                temp.append(arr[p1])
                p1 += 1
            else:
                temp.append(arr[p2])
                p2 += 1
        while p1 <= mid:
            temp.append(arr[p1])
            p1 += 1
        while p2 <= high:
            temp.append(arr[p2])
            p2 += 1

        for k in range(len(temp)):
            arr[low + k] = temp[k]