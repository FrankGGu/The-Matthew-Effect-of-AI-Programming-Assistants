class Solution:
    def findBestValue(self, arr: List[int], target: int) -> int:
        arr.sort()
        n = len(arr)
        prefix = [0]
        for num in arr:
            prefix.append(prefix[-1] + num)

        left, right = 0, arr[-1]
        best_value = 0
        min_diff = float('inf')

        while left <= right:
            mid = (left + right) // 2
            i = bisect.bisect_left(arr, mid)
            current_sum = prefix[i] + (n - i) * mid
            diff = abs(current_sum - target)

            if diff < min_diff or (diff == min_diff and mid < best_value):
                min_diff = diff
                best_value = mid

            if current_sum < target:
                left = mid + 1
            else:
                right = mid - 1

        return best_value