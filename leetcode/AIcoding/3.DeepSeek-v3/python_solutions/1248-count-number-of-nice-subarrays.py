class Solution:
    def numberOfSubarrays(self, nums: List[int], k: int) -> int:
        def atMost(k):
            res = left = 0
            for right in range(len(nums)):
                k -= nums[right] % 2
                while k < 0:
                    k += nums[left] % 2
                    left += 1
                res += right - left + 1
            return res

        return atMost(k) - atMost(k - 1)