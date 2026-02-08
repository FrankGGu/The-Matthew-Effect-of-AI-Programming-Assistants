import math
from functools import reduce

class Solution:
    def solve(self, n: int, nums: list[int], k: int) -> int:
        if n == 0:
            return 0

        # Handle n=1 case: No operations can be performed.
        # The single element must already be a multiple of k.
        if n == 1:
            if nums[0] % k == 0:
                return 0
            else:
                return -1

        # Calculate the greatest common divisor (GCD) of all numbers in the initial array.
        # Any number that can be formed by summing elements of the array must be a multiple of this GCD.
        # Consequently, the final target value X must also be a multiple of this GCD.
        common_divisor = reduce(math.gcd, nums)

        # The target value X must be a multiple of k (given condition).
        # X must also be a multiple of `common_divisor` (derived from operations).
        # Therefore, X must be a multiple of the least common multiple (LCM) of `common_divisor` and `k`.
        # lcm(a, b) = (a * b) // gcd(a, b)
        lcm_val = (common_divisor * k) // math.gcd(common_divisor, k)

        max_val = max(nums)

        # The target value X must be at least `max_val` because operations only increase numbers.
        # Calculate the smallest X that is a multiple of `lcm_val` and is >= `max_val`.
        # This is equivalent to ceil(max_val / lcm_val) * lcm_val.
        X_target = ((max_val + lcm_val - 1) // lcm_val) * lcm_val

        # Special case handling for when X_target equals max_val:
        # If X_target is exactly max_val, and there are elements in nums that are smaller than max_val,
        # then to increase a `num_i < max_val` to `max_val`, we would need to add `max_val - num_i`.
        # If we add any `num_j` (which is > 0) to `num_i`, `num_i` becomes `num_i + num_j`.
        # If `num_i + num_j > max_val`, we have overshot the target.
        # To guarantee that we can reach `max_val` without overshooting (which is generally impossible
        # with this operation type if `max_val` is the target and not all elements are equal),
        # the target `X` must be strictly greater than `max_val`.
        # In this specific scenario, we adjust X_target to the next multiple of `lcm_val`.
        all_equal = True
        for num in nums:
            if num != max_val:
                all_equal = False
                break

        if X_target == max_val and not all_equal:
            X_target += lcm_val

        # Calculate the total minimum operations.
        # For each number `num` in `nums`, we need to add `X_target - num`.
        # Since every element `nums[j]` is a multiple of `common_divisor`,
        # each operation effectively adds at least `common_divisor` to some element.
        # To add `D = X_target - num`, which is a multiple of `common_divisor`,
        # we need `D / common_divisor` operations.
        # The sum of these individual operations gives the total minimum operations.
        operations = 0
        for num in nums:
            operations += (X_target - num) // common_divisor

        return operations