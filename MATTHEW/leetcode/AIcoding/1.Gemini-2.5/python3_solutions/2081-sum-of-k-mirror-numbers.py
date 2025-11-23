class Solution:
    def sumKMirror(self, n: int, k: int) -> int:

        def is_palindrome(s: str) -> bool:
            """Checks if a string is a palindrome."""
            return s == s[::-1]

        def to_base_k(num: int, base: int) -> str:
            """Converts an integer to its base-k string representation."""
            if num == 0:
                return "0"
            digits = []
            while num > 0:
                digits.append(str(num % base))
                num //= base
            return "".join(digits[::-1])

        k_mirror_sum = 0
        count = 0

        # L is the length of the base-10 palindrome
        L = 1
        while count < n:
            # Determine the length of the "root" number from which palindromes are constructed.
            # For odd length L (e.g., L=3, palindrome 'aba'), root_length = (3+1)//2 = 2 (root 'ab').
            # For even length L (e.g., L=4, palindrome 'abba'), root_length = 4//2 = 2 (root 'ab').
            root_length = (L + 1) // 2

            # Calculate the range of root numbers for the current length L.
            # Smallest root number for a given root_length (e.g., for root_length=1, start_root=1; for root_length=2, start_root=10).
            start_root = 10**(root_length - 1)
            # Largest root number for a given root_length (e.g., for root_length=1, end_root=9; for root_length=2, end_root=99).
            end_root = 10**root_length - 1

            for root_num in range(start_root, end_root + 1):
                s_root = str(root_num)

                # Construct the base-10 palindrome from the root number.
                if L % 2 == 1: # Odd length palindrome (e.g., root "12" for L=3 -> "121")
                    s_palindrome = s_root + s_root[:-1][::-1]
                else: # Even length palindrome (e.g., root "12" for L=4 -> "1221")
                    s_palindrome = s_root + s_root[::-1]

                num = int(s_palindrome)

                # Check if the number is also a palindrome in base k.
                if is_palindrome(to_base_k(num, k)):
                    k_mirror_sum += num
                    count += 1
                    if count == n:
                        return k_mirror_sum

            L += 1

        return k_mirror_sum