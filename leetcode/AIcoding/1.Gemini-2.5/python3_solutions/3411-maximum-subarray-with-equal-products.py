import math

class Solution:
    # Precompute primes and prime factor maps as class attributes
    MAX_VAL = 1000

    # Sieve of Eratosthenes to find primes up to MAX_VAL
    _is_prime = [True] * (MAX_VAL + 1)
    _primes = []
    for p in range(2, MAX_VAL + 1):
        if _is_prime[p]:
            _primes.append(p)
            for multiple in range(p * p, MAX_VAL + 1, p):
                _is_prime[multiple] = False

    P = len(_primes) # Number of primes found

    # Precompute prime factorization for each number from 1 to MAX_VAL
    _prime_factors_map = {}
    _prime_factors_map[1] = tuple([0] * P) # Product of empty set is 1, represented by all zero counts
    for val in range(2, MAX_VAL + 1):
        factors = [0] * P
        temp_val = val
        for p_idx, p in enumerate(_primes):
            if temp_val == 1: # Optimization: if number is fully factored
                break
            while temp_val % p == 0:
                factors[p_idx] += 1
                temp_val //= p
        # If temp_val is still > 1, it must be a prime factor itself (and already covered by _primes)
        # The loop structure correctly handles this.
        _prime_factors_map[val] = tuple(factors)

    def maxSubarrayWithEqualProducts(self, nums: list[int]) -> int:
        n = len(nums)
        max_len = 0

        if n < 2: # A subarray needs at least two elements and a pivot k such that i <= k < j.
                  # This implies j - i + 1 >= 2, so min length is 2.
            return 0

        for k in range(n - 1): # k is the pivot index. nums[k] is in the left product, nums[k+1] in the right.

            # Calculate products P(i, k) for i from k down to 0
            left_products = {} # Stores (factor_tuple, has_zero) -> min_i for this product
            current_factors_left = [0] * self.P
            current_has_zero_left = False
            for i in range(k, -1, -1):
                if nums[i] == 0:
                    current_has_zero_left = True
                elif not current_has_zero_left: # Only update factors if no zero encountered yet
                    for p_idx, count in enumerate(self._prime_factors_map[nums[i]]):
                        current_factors_left[p_idx] += count

                key_left = (tuple(current_factors_left), current_has_zero_left)
                # Store the smallest i for this product. Since i iterates downwards,
                # the last assignment for a key will be the smallest i.
                left_products[key_left] = i

            # Calculate products P(k+1, j) for j from k+1 up to n-1
            right_products = {} # Stores (factor_tuple, has_zero) -> max_j for this product
            current_factors_right = [0] * self.P
            current_has_zero_right = False
            for j in range(k + 1, n):
                if nums[j] == 0:
                    current_has_zero_right = True
                elif not current_has_zero_right: # Only update factors if no zero encountered yet
                    for p_idx, count in enumerate(self._prime_factors_map[nums[j]]):
                        current_factors_right[p_idx] += count

                key_right = (tuple(current_factors_right), current_has_zero_right)
                # Store the largest j for this product. Since j iterates upwards,
                # the last assignment for a key will be the largest j.
                right_products[key_right] = j

            # Compare products found for left and right sides
            for key_left, i_val in left_products.items():
                if key_left in right_products:
                    j_val = right_products[key_left]
                    max_len = max(max_len, j_val - i_val + 1)

        return max_len