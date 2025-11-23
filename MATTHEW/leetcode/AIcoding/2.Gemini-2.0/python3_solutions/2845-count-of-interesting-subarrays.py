class Solution:
    def countInterestingSubarrays(self, nums: List[int], modulo: int, k: int) -> int:
        prefix_sum = {0: 1}
        curr_sum = 0
        count = 0
        for num in nums:
            if num % modulo == k:
                curr_sum += 1

            remainder = curr_sum % modulo

            target_remainder = (remainder - k) % modulo
            if target_remainder < 0:
                target_remainder += modulo

            if target_remainder in prefix_sum:
                count += prefix_sum[target_remainder]

            if remainder in prefix_sum:
                prefix_sum[remainder] += 1
            else:
                prefix_sum[remainder] = 1

        return count