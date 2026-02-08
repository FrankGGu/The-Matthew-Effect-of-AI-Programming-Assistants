class Solution:
    def countInterestingSubarrays(self, nums: List[int], modulo: int) -> int:
        prefix_sum = [0] * (len(nums) + 1)
        for i in range(len(nums)):
            prefix_sum[i + 1] = prefix_sum[i] + (nums[i] % modulo != 0)

        count = 0
        frequency = {0: 1}

        for i in range(1, len(prefix_sum)):
            mod_value = prefix_sum[i] % modulo
            if mod_value in frequency:
                count += frequency[mod_value]
            frequency[mod_value] = frequency.get(mod_value, 0) + 1

        return count