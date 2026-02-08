class Solution:
    def countOperationsToEmptyArray(self, nums: List[int]) -> int:
        n = len(nums)
        pos = {}
        for i in range(n):
            pos[nums[i]] = i

        sorted_nums = sorted(nums)

        ans = 0
        curr = 0

        for num in sorted_nums:
            idx = pos[num]

            if idx < curr:
                ans += n - curr
                ans += idx
            else:
                ans += idx - curr

            curr = idx

        return ans