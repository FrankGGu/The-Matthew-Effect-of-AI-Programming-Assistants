class Solution:
    def maximumXorProduct(self, a: int, b: int, n: int) -> int:
        MOD = 10**9 + 7

        # Initialize A_prime_val and B_prime_val with contributions from bits higher than n-1.
        # For bits j >= n, x_j is always 0. So (a XOR x)_j = a_j and (b XOR x)_j = b_j.
        # The mask `~((1 << n) - 1)` creates a number with 1s from bit n upwards and 0s below bit n.
        A_prime_val = a & (~((1 << n) - 1))
        B_prime_val = b & (~((1 << n) - 1))

        # x_val will store the constructed x for bits 0 to n-1.
        x_val = 0

        # Iterate from the most significant bit (n-1) down to the least significant bit (0).
        for i in range(n - 1, -1, -1):
            bit_a = (a >> i) & 1
            bit_b = (b >> i) & 1
            power_of_2_i = 1 << i

            if bit_a == bit_b:
                # If the i-th bits of a and b are the same:
                # To maximize the product, we want both (a XOR x) and (b XOR x) to have a 1 at this position.
                # This means (bit_a XOR x_i) must be 1.
                # So, x_i should be 1 - bit_a.
                x_i = 1 - bit_a
                x_val |= (x_i << i)
                A_prime_val += power_of_2_i
                B_prime_val += power_of_2_i
            else: # bit_a != bit_b
                # If the i-th bits of a and b are different:
                # One of (a XOR x)_i or (b XOR x)_i will be 1, and the other will be 0, regardless of x_i.
                # To maximize the product, we want A_prime_val and B_prime_val to be as close as possible.
                # If A_prime_val is currently smaller or equal, we give the 2^i contribution to A_prime_val.
                # Otherwise, we give it to B_prime_val to try and balance them.
                if A_prime_val <= B_prime_val:
                    # Make (a XOR x)_i get 1.
                    # This means x_i should be 1 - bit_a.
                    x_i = 1 - bit_a
                    x_val |= (x_i << i)
                    A_prime_val += power_of_2_i
                else:
                    # Make (b XOR x)_i get 1.
                    # This means x_i should be 1 - bit_b.
                    x_i = 1 - bit_b
                    x_val |= (x_i << i)
                    B_prime_val += power_of_2_i

        # The final A_prime_val and B_prime_val represent (a XOR x_val) and (b XOR x_val) respectively.
        # Calculate their product modulo MOD.
        return ((A_prime_val % MOD) * (B_prime_val % MOD)) % MOD