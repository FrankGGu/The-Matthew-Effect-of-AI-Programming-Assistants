class Solution:
    def waysToSplit(self, nums: List[int]) -> int:
        total = sum(nums)
        n = len(nums)
        left_sum = 0
        count = 0
        mod = 10**9 + 7

        for i in range(n - 2):
            left_sum += nums[i]
            if left_sum * 3 > total:
                break

            low, high = i + 1, n - 1

            while low <= high:
                mid = (low + high) // 2
                right_sum = total - left_sum - sum(nums[i + 1:mid + 1])

                if right_sum >= left_sum:
                    low = mid + 1
                else:
                    high = mid - 1

            count += max(0, high - (i + 1) + 1)

        return count % mod