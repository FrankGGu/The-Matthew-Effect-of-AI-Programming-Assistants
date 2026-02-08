class Solution:
    def reversePairs(self, nums: list[int]) -> int:

        def merge_sort(arr, start, end):
            if start >= end:
                return 0

            mid = (start + end) // 2

            count = merge_sort(arr, start, mid)
            count += merge_sort(arr, mid + 1, end)
            count += merge(arr, start, mid, end)

            return count

        def merge(arr, start, mid, end):
            local_count = 0
            j = mid + 1

            for i in range(start, mid + 1):
                while j <= end and arr[i] > 2 * arr[j]:
                    j += 1
                local_count += (j - (mid + 1))

            temp = []
            p1 = start
            p2 = mid + 1

            while p1 <= mid and p2 <= end:
                if arr[p1] <= arr[p2]:
                    temp.append(arr[p1])
                    p1 += 1
                else:
                    temp.append(arr[p2])
                    p2 += 1

            while p1 <= mid:
                temp.append(arr[p1])
                p1 += 1

            while p2 <= end:
                temp.append(arr[p2])
                p2 += 1

            for k in range(len(temp)):
                arr[start + k] = temp[k]

            return local_count

        return merge_sort(nums, 0, len(nums) - 1)