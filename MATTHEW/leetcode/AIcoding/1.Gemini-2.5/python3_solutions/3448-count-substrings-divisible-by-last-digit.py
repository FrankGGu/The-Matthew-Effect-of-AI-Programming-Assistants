class Solution:
    def countSubstrings(self, s: str) -> int:
        n = len(s)
        if n == 0:
            return 0

        divisor = int(s[-1])
        if divisor == 0:
            return 0

        ans = 0

        if divisor == 1:
            # Any integer is divisible by 1.
            # Number of substrings is n * (n + 1) / 2.
            ans = n * (n + 1) // 2
        elif divisor == 2:
            # A number is divisible by 2 if its last digit is even.
            # For a substring s[i:j+1], it's divisible by 2 if int(s[j]) % 2 == 0.
            # If s[j] is even, then all substrings ending at s[j] are divisible by 2.
            # There are (j + 1) such substrings: s[0:j+1], s[1:j+1], ..., s[j:j+1].
            for j in range(n):
                if int(s[j]) % 2 == 0:
                    ans += (j + 1)
        elif divisor == 3:
            # A number val(s[i:j+1]) is divisible by 3 if (P[j+1] - P[i] * 10^(j+1-i)) % 3 == 0.
            # Since 10 % 3 == 1, this simplifies to (P[j+1] - P[i]) % 3 == 0, or P[j+1] % 3 == P[i] % 3.
            # P[k] is the integer value of s[0:k].
            current_prefix_mod_3 = 0
            freq = {0: 1}  # Initialize with P[0] = 0 (empty prefix)
            for j in range(n):
                digit = int(s[j])
                current_prefix_mod_3 = (current_prefix_mod_3 * 10 + digit) % 3
                ans += freq.get(current_prefix_mod_3, 0)
                freq[current_prefix_mod_3] = freq.get(current_prefix_mod_3, 0) + 1
        elif divisor == 4:
            # A number is divisible by 4 if the number formed by its last two digits is divisible by 4.
            for j in range(n):
                # Case 1: Substring of length 1 (s[j:j+1])
                if int(s[j]) % 4 == 0:
                    ans += 1
                # Case 2: Substring of length >= 2 (s[i:j+1] where i <= j-1)
                # If the number formed by s[j-1:j+1] is divisible by 4, then all substrings s[i:j+1]
                # for i from 0 to j-1 are divisible by 4.
                if j >= 1:
                    last_two_digits_num = int(s[j-1:j+1])
                    if last_two_digits_num % 4 == 0:
                        ans += j  # There are 'j' such starting positions (0, 1, ..., j-1)
        elif divisor == 5:
            # A number is divisible by 5 if its last digit is 0 or 5.
            # For a substring s[i:j+1], it's divisible by 5 if int(s[j]) % 5 == 0.
            # If s[j] is 0 or 5, then all substrings ending at s[j] are divisible by 5.
            # There are (j + 1) such substrings: s[0:j+1], s[1:j+1], ..., s[j:j+1].
            for j in range(n):
                if int(s[j]) % 5 == 0:
                    ans += (j + 1)
        elif divisor == 6:
            # A number is divisible by 6 if it's divisible by both 2 and 3.
            # Divisible by 2: last digit of the substring must be even.
            # Divisible by 3: P[j+1] % 3 == P[i] % 3 (same as for divisor 3).
            current_prefix_mod_3 = 0
            freq = {0: 1}  # Initialize with P[0] = 0
            for j in range(n):
                digit = int(s[j])
                current_prefix_mod_3 = (current_prefix_mod_3 * 10 + digit) % 3
                if digit % 2 == 0:  # Check divisibility by 2 for the last digit of the current substring
                    ans += freq.get(current_prefix_mod_3, 0)
                freq[current_prefix_mod_3] = freq.get(current_prefix_mod_3, 0) + 1
        elif divisor == 7:
            # A number val(s[i:j+1]) is divisible by 7 if (P[j+1] - P[i] * 10^(j+1-i)) % 7 == 0.
            # This can be rewritten as (P[j+1] * 10^(-(j+1))) % 7 == (P[i] * 10^(-i)) % 7.
            # Let rem[k] = (P[k] * 10^(-k)) % 7. We need to count pairs (i, j+1) where rem[j+1] == rem[i].
            inv10 = pow(10, -1, 7)  # Modular multiplicative inverse of 10 mod 7 is 5 (10*5 = 50 = 7*7 + 1)
            current_prefix_val_mod_7 = 0
            current_inv_power_of_10_mod_7 = 1  # Represents 10^(-k) % 7 for k=0, 1, ..., j
            freq = {0: 1}  # For rem[0] = (P[0] * 10^0) % 7 = 0
            for j in range(n):
                digit = int(s[j])
                current_prefix_val_mod_7 = (current_prefix_val_mod_7 * 10 + digit) % 7
                current_inv_power_of_10_mod_7 = (current_inv_power_of_10_mod_7 * inv10) % 7
                target_rem_val = (current_prefix_val_mod_7 * current_inv_power_of_10_mod_7) % 7
                ans += freq.get(target_rem_val, 0)
                freq[target_rem_val] = freq.get(target_rem_val, 0) + 1
        elif divisor == 8:
            # A number is divisible by 8 if the number formed by its last three digits is divisible by 8.
            for j in range(n):
                # Case 1: Substring of length 1 (s[j:j+1])
                if int(s[j]) % 8 == 0:
                    ans += 1
                # Case 2: Substring of length 2 (s[j-1:j+1])
                if j >= 1:
                    last_two_digits_num = int(s[j-1:j+1])
                    if last_two_digits_num % 8 == 0:
                        ans += 1  # Only s[j-1:j+1] itself
                # Case 3: Substring of length >= 3 (s[i:j+1] where i <= j-2)
                # If the number formed by s[j-2:j+1] is divisible by 8, then all substrings s[i:j+1]
                # for i from 0 to j-2 are divisible by 8.
                if j >= 2:
                    last_three_digits_num = int(s[j-2:j+1])
                    if last_three_digits_num % 8 == 0:
                        ans += (j - 1)  # There are 'j-1' such starting positions (0, 1, ..., j-2)
        elif divisor == 9:
            # A number val(s[i:j+1]) is divisible by 9 if (P[j+1] - P[i] * 10^(j+1-i)) % 9 == 0.
            # This can be rewritten as (P[j+1] * 10^(-(j+1))) % 9 == (P[i] * 10^(-i)) % 9.
            # Let rem[k] = (P[k] * 10^(-k)) % 9. We need to count pairs (i, j+1) where rem[j+1] == rem[i].
            inv10 = pow(10, -1, 9)  # Modular multiplicative inverse of 10 mod 9 is 1 (10*1 = 10 = 1*9 + 1)
            current_prefix_val_mod_9 = 0
            current_inv_power_of_10_mod_9 = 1  # Represents 10^(-k) % 9 for k=0, 1, ..., j
            freq = {0: 1}  # For rem[0] = (P[0] * 10^0) % 9 = 0
            for j in range(n):
                digit = int(s[j])
                current_prefix_val_mod_9 = (current_prefix_val_mod_9 * 10 + digit) % 9
                current_inv_power_of_10_mod_9 = (current_inv_power_of_10_mod_9 * inv10) % 9
                target_rem_val = (current_prefix_val_mod_9 * current_inv_power_of_10_mod_9) % 9
                ans += freq.get(target_rem_val, 0)
                freq[target_rem_val] = freq.get(target_rem_val, 0) + 1

        return ans