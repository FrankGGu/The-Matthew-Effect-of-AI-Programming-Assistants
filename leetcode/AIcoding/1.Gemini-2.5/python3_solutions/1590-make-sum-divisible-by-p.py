class Solution:
    def minSubarray(self, nums: list[int], p: int) -> int:
        total_sum = sum(nums)

        target_remainder = total_sum % p

        if target_remainder == 0:
            return 0

        n = len(nums)
        min_len = n 

        current_sum_mod_p = 0

        remainder_map = {0: -1} 

        for i in range(n):
            current_sum_mod_p = (current_sum_mod_p + nums[i]) % p

            required_prev_remainder = (current_sum_mod_p - target_remainder + p) % p

            if required_prev_remainder in remainder_map:
                prev_index = remainder_map[required_prev_remainder]
                min_len = min(min_len, i - prev_index)

            remainder_map[current_sum_mod_p] = i

        if min_len == n:
            return -1
        else:
            return min_len