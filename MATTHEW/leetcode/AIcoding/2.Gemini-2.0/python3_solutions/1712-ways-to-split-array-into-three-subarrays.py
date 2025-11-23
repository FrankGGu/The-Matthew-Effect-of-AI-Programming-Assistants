class Solution:
    def waysToSplit(self, nums: List[int]) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        count = 0
        for i in range(1, n - 1):
            left_sum = prefix_sum[i]

            left = i + 1
            right = n - 1

            first_valid_j = -1
            while left <= right:
                mid = (left + right) // 2
                mid_sum = prefix_sum[mid] - prefix_sum[i]

                if mid_sum >= left_sum:
                    first_valid_j = mid
                    right = mid - 1
                else:
                    left = mid + 1

            if first_valid_j == -1:
                continue

            left = i + 1
            right = n - 1

            last_valid_j = -1
            while left <= right:
                mid = (left + right) // 2
                mid_sum = prefix_sum[mid] - prefix_sum[i]
                right_sum = prefix_sum[n] - prefix_sum[mid]

                if mid_sum <= right_sum:
                    last_valid_j = mid
                    left = mid + 1
                else:
                    right = mid - 1

            if last_valid_j == -1:
                continue

            count = (count + (last_valid_j - first_valid_j + 1)) % (10**9 + 7)

        return count