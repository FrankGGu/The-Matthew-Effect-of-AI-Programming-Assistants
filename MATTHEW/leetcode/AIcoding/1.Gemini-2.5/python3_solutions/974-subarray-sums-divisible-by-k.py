class Solution:
    def subarraysDivByK(self, nums: list[int], k: int) -> int:
        remainders_count = {0: 1}
        current_sum = 0
        ans = 0

        for num in nums:
            current_sum += num
            remainder = current_sum % k

            if remainder in remainders_count:
                ans += remainders_count[remainder]
                remainders_count[remainder] += 1
            else:
                remainders_count[remainder] = 1

        return ans