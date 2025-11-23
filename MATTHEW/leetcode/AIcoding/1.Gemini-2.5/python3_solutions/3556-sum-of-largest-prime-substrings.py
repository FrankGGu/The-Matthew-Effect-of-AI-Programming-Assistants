import math

class Solution:
    def sumOfLargestPrimeSubstrings(self, s: str) -> int:
        MAX_NUM = 1000000  # Maximum value for a prime substring.
                           # Numbers up to 1,000,000 have at most 7 digits.
                           # This implies that we only need to consider substrings
                           # up to 7 characters long.

        is_prime = [True] * (MAX_NUM + 1)
        is_prime[0] = is_prime[1] = False
        for p in range(2, int(math.sqrt(MAX_NUM)) + 1):
            if is_prime[p]:
                for multiple in range(p * p, MAX_NUM + 1, p):
                    is_prime[multiple] = False

        total_sum = 0
        n = len(s)

        for i in range(n):
            current_largest_prime = 0
            current_num = 0

            # Iterate for substring length up to 7 digits.
            # j goes from i to min(n-1, i + 6), making the substring length at most 7.
            for j in range(i, min(n, i + 7)): 
                digit = int(s[j])

                # Handle leading zeros:
                # If the substring starts with '0' and has more than one digit (e.g., "01", "013"),
                # it's considered an invalid number representation.
                # For such cases, we break the inner loop for this starting 'i'.
                if s[i] == '0' and j > i:
                    break

                current_num = current_num * 10 + digit

                # If the current number exceeds MAX_NUM, any longer substring
                # starting at 'i' will also exceed MAX_NUM. So, we break.
                if current_num > MAX_NUM:
                    break

                # Check if current_num is prime (must be >= 2)
                if current_num >= 2 and is_prime[current_num]:
                    current_largest_prime = current_num

            total_sum += current_largest_prime

        return total_sum