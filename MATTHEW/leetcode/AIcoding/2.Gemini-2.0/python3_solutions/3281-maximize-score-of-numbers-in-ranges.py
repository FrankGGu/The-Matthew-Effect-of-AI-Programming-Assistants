class Solution:
    def maxScore(self, nums: List[int], queries: List[List[int]]) -> int:
        nums.sort()
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        ans = []
        for l, r in queries:
            left, right = 0, n - 1
            res = -1
            while left <= right:
                mid = (left + right) // 2
                if nums[mid] >= l:
                    res = mid
                    right = mid - 1
                else:
                    left = mid + 1

            start_index = res if res != -1 else n

            left, right = 0, n - 1
            res = -1
            while left <= right:
                mid = (left + right) // 2
                if nums[mid] <= r:
                    res = mid
                    left = mid + 1
                else:
                    right = mid - 1
            end_index = res if res != -1 else -1

            if end_index < start_index:
                ans.append(0)
            else:
                ans.append(prefix_sum[end_index + 1] - prefix_sum[start_index])

        return sum(ans)