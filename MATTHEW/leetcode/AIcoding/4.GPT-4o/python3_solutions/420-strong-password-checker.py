class Solution:
    def strongPasswordChecker(self, password: str) -> int:
        n = len(password)
        has_lower = any(c.islower() for c in password)
        has_upper = any(c.isupper() for c in password)
        has_digit = any(c.isdigit() for c in password)

        missing_types = 3 - (has_lower + has_upper + has_digit)

        replace_count = 0
        one_pair = 0
        two_pair = 0

        i = 2
        while i < n:
            if password[i] == password[i - 1] == password[i - 2]:
                length = 2
                while i < n and password[i] == password[i - 1]:
                    length += 1
                    i += 1

                replace_count += length // 3
                if length % 3 == 0:
                    one_pair += 1
                elif length % 3 == 1:
                    two_pair += 1
            else:
                i += 1

        if n < 6:
            return max(6 - n, missing_types)

        elif n <= 20:
            return max(replace_count, missing_types)

        else:
            excess = n - 20
            replace_count -= min(excess, one_pair)  
            excess -= min(excess, one_pair)
            replace_count -= min(excess // 2, two_pair)  
            excess -= min(excess // 2, two_pair)  
            replace_count -= excess // 3  
            return n - 20 + max(replace_count, missing_types)