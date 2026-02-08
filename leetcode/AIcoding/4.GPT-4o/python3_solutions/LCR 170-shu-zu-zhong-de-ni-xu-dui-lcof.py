class Solution:
    def reversePairs(self, nums: List[int]) -> int:
        def merge_and_count(arr, temp_arr, left, mid, right):
            i = left    
            j = mid + 1 
            k = left    
            count = 0

            while i <= mid and j <= right:
                if arr[i] <= arr[j]:
                    temp_arr[k] = arr[i]
                    i += 1
                else:
                    temp_arr[k] = arr[j]
                    count += (mid - i + 1)
                    j += 1
                k += 1

            while i <= mid:
                temp_arr[k] = arr[i]
                i += 1
                k += 1

            while j <= right:
                temp_arr[k] = arr[j]
                j += 1
                k += 1

            for i in range(left, right + 1):
                arr[i] = temp_arr[i]

            return count

        def merge_sort_and_count(arr, temp_arr, left, right):
            count = 0
            if left < right:
                mid = (left + right) // 2
                count += merge_sort_and_count(arr, temp_arr, left, mid)
                count += merge_sort_and_count(arr, temp_arr, mid + 1, right)
                count += merge_and_count(arr, temp_arr, left, mid, right)
            return count

        n = len(nums)
        temp_arr = [0] * n
        return merge_sort_and_count(nums, temp_arr, 0, n - 1)