class Solution:
    def answerQueries(self, nums: list[int], queries: list[int]) -> list[int]:
        nums.sort()
        prefix_sum = [0] * (len(nums) + 1)
        for i in range(len(nums)):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        result = []
        for q in queries:
            l, r = 0, len(nums)
            ans = 0
            while l <= r:
                mid = (l + r) // 2
                if prefix_sum[mid] <= q:
                    ans = mid
                    l = mid + 1
                else:
                    r = mid - 1
            result.append(ans)

        return result