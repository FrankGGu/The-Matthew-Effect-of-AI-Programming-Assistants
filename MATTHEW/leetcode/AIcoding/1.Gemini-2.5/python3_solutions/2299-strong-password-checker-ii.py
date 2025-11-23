class Solution:
    def strongPasswordCheckerII(self, password: str) -> bool:
        if len(password) < 8:
            return False

        has_lower = False
        has_upper = False
        has_digit = False
        has_special = False

        special_chars = set("!@#$%^&*()-+")

        for i in range(len(password)):
            char = password[i]

            if char.islower():
                has_lower = True
            elif char.isupper():
                has_upper = True
            elif char.isdigit():
                has_digit = True
            elif char in special_chars:
                has_special = True

            if i > 0 and password[i] == password[i-1]:
                return False

        return has_lower and has_upper and has_digit and has_special