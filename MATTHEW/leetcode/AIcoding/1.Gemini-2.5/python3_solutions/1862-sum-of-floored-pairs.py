class Solution:
    def sumOfFlooredPairs(self, nums: list[int]) -> int:
        MOD = 10**9 + 7

        max_val = 0
        for num in nums:
            max_val = max(max_val, num)

        counts = [0] * (max_val + 1)
        for num in nums:
            counts[num] += 1

        prefix_counts = [0] * (max_val + 1)
        # prefix_counts[i] stores the sum of counts[0] through counts[i]
        # which represents the total number of elements in the original nums array that are less than or equal to i.
        # Since nums[i] >= 1, counts[0] will always be 0.
        for i in range(1, max_val + 1):
            prefix_counts[i] = prefix_counts[i-1] + counts[i]

        total_sum = 0

        # Iterate through all possible denominators 'y' (values from 1 to max_val)
        # 'y' represents a potential nums[j]
        for y in range(1, max_val + 1):
            # If 'y' does not appear in the input array 'nums', it cannot be a denominator, so skip.
            if counts[y] == 0:
                continue

            # For a fixed 'y', iterate through all possible quotients 'k'
            # 'k' represents floor(x / y)
            # x values that result in floor(x / y) = k are in the range [k*y, (k+1)*y - 1]
            for k in range(max_val // y + 1): 
                lower_bound_x = k * y
                upper_bound_x = (k + 1) * y - 1

                # If the lower bound for 'x' is already greater than max_val,
                # there are no more 'x' values in 'nums' that can satisfy this 'k', so break.
                if lower_bound_x > max_val:
                    break

                # Calculate the count of numbers 'x' in 'nums' such that
                # lower_bound_x <= x <= min(upper_bound_x, max_val).
                # This is obtained using prefix_counts: prefix_counts[R] - prefix_counts[L-1].

                count_x_in_range = prefix_counts[min(upper_bound_x, max_val)]
                if lower_bound_x > 0:
                    count_x_in_range -= prefix_counts[lower_bound_x - 1]

                # Add to the total sum:
                # (number of times 'y' appears as a denominator) * (quotient 'k') * (number of times 'x' appears as a numerator in this range)
                term = (counts[y] * k * count_x_in_range) % MOD
                total_sum = (total_sum + term) % MOD

        return total_sum