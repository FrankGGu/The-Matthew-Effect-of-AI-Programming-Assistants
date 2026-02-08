class Solution:
    def numSubseq(self, nums: List[int], target: int) -> int:
        nums.sort()
        n = len(nums)
        ans = 0
        mod = 10**9 + 7
        power = [1] * (n + 1)
        for i in range(1, n + 1):
            power[i] = (power[i - 1] * 2) % mod

        for i in range(n):
            if nums[i] * 2 > target:
                break
            l, r = i, n - 1
            idx = -1
            while l <= r:
                mid = (l + r) // 2
                if nums[i] + nums[mid] <= target:
                    idx = mid
                    l = mid + 1
                else:
                    r = mid - 1
            ans = (ans + power[idx - i]) % mod
        return ans