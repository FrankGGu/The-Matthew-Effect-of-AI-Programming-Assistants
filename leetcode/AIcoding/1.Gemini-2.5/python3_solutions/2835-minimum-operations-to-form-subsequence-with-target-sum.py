import math

class Solution:
    def minOperations(self, nums: list[int], target: int) -> int:
        # counts[i] stores the number of 2^i available
        # Max power of 2 for 10^9 is 2^29. So indices 0-29.
        # Using 31 for safety (indices 0 to 30).
        counts = [0] * 31 

        for num in nums:
            power = int(math.log2(num))
            counts[power] += 1

        ans = 0
        # 'carry' represents the number of 2^i units available from lower bits or current counts[i]
        # that are not used for the target bit 'i', and thus can be carried to bit 'i+1'.
        carry = 0 

        # Iterate through bits from 0 up to 30 (covering target up to 10^9 and nums up to 10^9)
        for i in range(31): 
            # Add current count of 2^i to carry
            carry += counts[i]

            # If the i-th bit of target is 1, we need a 2^i
            if (target >> i) & 1:
                if carry > 0:
                    # Use one 2^i from available carry
                    carry -= 1
                else:
                    # We need a 2^i but don't have it directly. Must split a larger power.
                    # Find the smallest j > i such that counts[j] > 0.
                    # This is a greedy choice to minimize operations.
                    found_larger = False
                    for j in range(i + 1, 31):
                        if counts[j] > 0:
                            counts[j] -= 1 # Use this 2^j
                            ans += (j - i) # It takes j-i operations to get 2^i from 2^j

                            # When 2^j is split to get 2^i, it effectively produces one 2^i
                            # (which we use for the target bit) and one of each 2^(i+1), ..., 2^(j-1)
                            # as "leftovers". These leftovers are added to counts for future use.
                            for k in range(i + 1, j):
                                counts[k] += 1

                            found_larger = True
                            break

                    if not found_larger:
                        # If we couldn't find any larger power to split, target cannot be formed.
                        return -1

            # Carry over to the next bit. Two 2^i units make one 2^(i+1) unit.
            # This is done by dividing the remaining 'carry' by 2.
            # The result is the number of 2^(i+1) units that can be used for the next bit.
            carry //= 2

        return ans