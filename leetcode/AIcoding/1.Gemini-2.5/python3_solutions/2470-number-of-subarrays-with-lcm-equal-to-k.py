import math

class Solution:
    def subarrayLCM(self, nums: list[int], k: int) -> int:
        count = 0
        n = len(nums)

        for i in range(n):
            current_lcm = 1
            for j in range(i, n):
                if k % nums[j] != 0:
                    # If nums[j] is not a divisor of k, then the LCM of any subarray containing nums[j]
                    # cannot be k. So, we can stop extending this subarray.
                    break

                # Calculate LCM
                # lcm(a, b) = (a * b) // gcd(a, b)
                current_lcm = (current_lcm * nums[j]) // math.gcd(current_lcm, nums[j])

                if current_lcm > k:
                    # If current_lcm exceeds k, it will only grow larger (or stay the same)
                    # with further elements, so it can never become k.
                    break

                if current_lcm == k:
                    count += 1

        return count