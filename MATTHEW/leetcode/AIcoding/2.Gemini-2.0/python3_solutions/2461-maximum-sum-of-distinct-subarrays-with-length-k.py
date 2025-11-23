class Solution:
    def maximumSubarraySum(self, nums: List[int], k: int) -> int:
        if len(nums) < k:
            return 0

        max_sum = 0
        curr_sum = 0
        seen = set()

        for i in range(k):
            if nums[i] in seen:
                curr_sum = -1
                break
            curr_sum += nums[i]
            seen.add(nums[i])

        if curr_sum != -1:
            max_sum = curr_sum

        for i in range(k, len(nums)):
            seen.remove(nums[i - k])
            curr_sum -= nums[i - k]

            if nums[i] in seen:
                curr_sum = -1
            else:
                curr_sum += nums[i]
                seen.add(nums[i])

            if curr_sum != -1:
                max_sum = max(max_sum, curr_sum)

        return max_sum