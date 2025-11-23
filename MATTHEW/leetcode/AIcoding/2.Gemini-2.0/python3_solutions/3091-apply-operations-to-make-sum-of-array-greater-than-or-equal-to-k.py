class Solution:
    def check(self, nums, k, x):
        s = 0
        cnt = 0
        for num in nums:
            if num >= x:
                s += num
                cnt += 1
        if s >= k:
            return True

        n = len(nums)
        q = []
        curr_sum = 0

        for i in range(n):
            if nums[i] >= x:
                curr_sum += nums[i]
                q.append(nums[i])

                while curr_sum >= k:
                    return True
            else:

                while q:
                    curr_sum -= q.pop(0)
        return False

    def applyOperations(self, nums: list[int], k: int) -> int:
        l, r = 0, max(nums) + 1
        while l < r:
            mid = (l + r) // 2
            if self.check(nums, k, mid):
                l = mid + 1
            else:
                r = mid
        return l - 1