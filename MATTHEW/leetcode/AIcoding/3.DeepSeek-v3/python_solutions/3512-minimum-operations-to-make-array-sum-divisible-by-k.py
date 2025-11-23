class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        total_sum = sum(nums)
        remainder = total_sum % k
        if remainder == 0:
            return 0

        prefix_remainders = {}
        prefix_remainders[0] = -1
        current_remainder = 0
        min_len = float('inf')

        for i in range(len(nums)):
            current_remainder = (current_remainder + nums[i]) % k
            target_remainder = (current_remainder - remainder) % k
            if target_remainder in prefix_remainders:
                min_len = min(min_len, i - prefix_remainders[target_remainder])
            prefix_remainders[current_remainder] = i

        return min_len if min_len != float('inf') else -1