import math

class Solution:
    def minOperations(self, nums: list[int]) -> int:
        n = len(nums)

        # Count existing '1's in the array
        count_ones = nums.count(1)

        # Case 1: If there is at least one '1' in the array
        # We don't need to perform operations to create a '1'.
        # We just need to propagate the existing '1's to all other elements.
        # Each operation (e.g., replacing x with gcd(x, 1) which results in 1)
        # effectively turns one non-'1' element into '1'.
        # So, we need (n - count_ones) operations to make all elements '1'.
        if count_ones > 0:
            return n - count_ones

        # Case 2: No '1's in the array initially.
        # We must perform operations to create at least one '1'.
        # To do this, we need to find the shortest contiguous subarray whose greatest common divisor (GCD) is 1.
        # If a subarray nums[i...j] has GCD 1, it takes (j - i) operations to make one of its elements '1'.
        # For example, for [a, b, c] where gcd(a,b,c)=1:
        # 1. Replace b with gcd(b,c) -> [a, gcd(b,c)] (1 operation)
        # 2. Replace a with gcd(a, gcd(b,c)) -> [1] (1 operation)
        # Total operations = (length of subarray - 1).

        min_ops_to_create_one = float('inf')

        for i in range(n):
            current_gcd = nums[i]
            for j in range(i + 1, n):
                current_gcd = math.gcd(current_gcd, nums[j])
                if current_gcd == 1:
                    # Found a subarray nums[i...j] whose GCD is 1.
                    # The length of this subarray is (j - i + 1).
                    # Operations to make one element '1' from this subarray: (length - 1) = (j - i).
                    min_ops_to_create_one = min(min_ops_to_create_one, j - i)
                    # Once we find a GCD of 1 for a given 'i',
                    # extending 'j' further will only increase the number of operations (j - i),
                    # so we can break the inner loop and move to the next 'i'.
                    break 

        # If min_ops_to_create_one is still infinity, it means no subarray's GCD is 1.
        # Therefore, it's impossible to create a '1' in the array.
        if min_ops_to_create_one == float('inf'):
            return -1

        # Total operations = (operations to create the first '1') + (operations to propagate that '1' to the remaining n-1 elements).
        # Operations to create the first '1' is min_ops_to_create_one.
        # Operations to propagate that '1' to the other n-1 elements is (n - 1).
        return min_ops_to_create_one + (n - 1)