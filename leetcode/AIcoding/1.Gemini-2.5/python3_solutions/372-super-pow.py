class Solution:
    def superPow(self, a: int, b: list[int]) -> int:
        MOD = 1337

        def pow_mod(base, exponent, modulus):
            return pow(base, exponent, modulus)

        if not b:
            return 1

        last_digit = b.pop()

        # Calculate (a^(b_without_last_digit))^10 % MOD
        # Recursively call superPow for a^(b_without_last_digit)
        # Then raise that result to the power of 10
        part1 = pow_mod(self.superPow(a, b), 10, MOD)

        # Calculate a^last_digit % MOD
        part2 = pow_mod(a, last_digit, MOD)

        # Combine the two parts: (part1 * part2) % MOD
        return (part1 * part2) % MOD