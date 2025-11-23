class Solution:
    def checkSubarraySum(self, nums: List[int], k: int) -> bool:
        if len(nums) < 2:
            return False

        seen = {0: -1}
        prefix_sum = 0

        for i, num in enumerate(nums):
            prefix_sum += num

            if k != 0:
                prefix_sum %= k

            if prefix_sum in seen:
                if i - seen[prefix_sum] > 1:
                    return True
            else:
                seen[prefix_sum] = i

        return False