class Solution:
    def checkSubarraySum(self, nums: List[int], k: int) -> bool:
        prefix_sum = 0
        mod_map = {0: -1}

        for i, num in enumerate(nums):
            prefix_sum += num
            mod = prefix_sum % k if k != 0 else prefix_sum
            if mod in mod_map:
                if i - mod_map[mod] > 1:
                    return True
            else:
                mod_map[mod] = i

        return False