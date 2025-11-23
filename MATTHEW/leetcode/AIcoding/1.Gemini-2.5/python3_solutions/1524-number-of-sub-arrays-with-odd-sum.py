class Solution:
    def numOfSubarrays(self, arr: list[int]) -> int:
        MOD = 10**9 + 7

        even_count = 1
        odd_count = 0

        current_sum = 0
        total_odd_subarrays = 0

        for num in arr:
            current_sum += num

            if current_sum % 2 == 1:
                total_odd_subarrays = (total_odd_subarrays + even_count) % MOD
                odd_count += 1
            else:
                total_odd_subarrays = (total_odd_subarrays + odd_count) % MOD
                even_count += 1

        return total_odd_subarrays