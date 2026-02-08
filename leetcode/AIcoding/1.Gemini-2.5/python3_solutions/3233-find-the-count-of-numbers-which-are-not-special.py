class Solution:
    def nonSpecialCount(self, l: int, r: int) -> int:
        # The maximum possible prime whose square could be less than or equal to r.
        # If p*p <= r, then p <= sqrt(r).
        max_p_check = int(r**0.5)

        # Sieve of Eratosthenes to find primes up to max_p_check
        # is_prime[i] will be True if i is prime, False otherwise.
        is_prime = [True] * (max_p_check + 1)
        if max_p_check >= 0:
            is_prime[0] = False
        if max_p_check >= 1:
            is_prime[1] = False

        # Iterate from 2 up to sqrt(max_p_check)
        for p in range(2, int(max_p_check**0.5) + 1):
            if is_prime[p]:
                # Mark multiples of p as not prime
                for multiple in range(p*p, max_p_check + 1, p):
                    is_prime[multiple] = False

        special_count = 0
        # Iterate through numbers from 2 to max_p_check to find primes
        for p in range(2, max_p_check + 1):
            if is_prime[p]:
                # Calculate the square of the prime number
                square = p * p

                # Check if this special number (p*p) falls within the given range [l, r]
                # Since p <= max_p_check, we know p*p <= max_p_check*max_p_check <= r.
                # So, we only need to check the lower bound 'l'.
                if square >= l:
                    special_count += 1

        # Total numbers in the range [l, r]
        total_numbers_in_range = r - l + 1

        # The count of numbers that are NOT special is total numbers minus special numbers
        return total_numbers_in_range - special_count