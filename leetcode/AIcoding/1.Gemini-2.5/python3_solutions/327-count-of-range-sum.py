class Solution:
    def countRangeSum(self, nums: list[int], lower: int, upper: int) -> int:
        n = len(nums)
        prefix_sums = [0] * (n + 1)
        for i in range(n):
            prefix_sums[i+1] = prefix_sums[i] + nums[i]

        def merge_sort_and_count(arr, start, end):
            if start == end:
                return 0

            mid = (start + end) // 2

            count = merge_sort_and_count(arr, start, mid) + \
                    merge_sort_and_count(arr, mid + 1, end)

            k = start
            l = start

            for j in range(mid + 1, end + 1):
                while k <= mid and arr[k] < arr[j] - upper:
                    k += 1
                while l <= mid and arr[l] <= arr[j] - lower:
                    l += 1
                count += (l - k)

            merged = []
            p1, p2 = start, mid + 1
            while p1 <= mid and p2 <= end:
                if arr[p1] < arr[p2]:
                    merged.append(arr[p1])
                    p1 += 1
                else:
                    merged.append(arr[p2])
                    p2 += 1
            while p1 <= mid:
                merged.append(arr[p1])
                p1 += 1
            while p2 <= end:
                merged.append(arr[p2])
                p2 += 1

            for i in range(len(merged)):
                arr[start + i] = merged[i]

            return count

        return merge_sort_and_count(prefix_sums, 0, n)