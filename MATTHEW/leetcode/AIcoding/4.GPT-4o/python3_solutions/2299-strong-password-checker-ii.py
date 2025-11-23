class Solution:
    def strongPasswordCheckerII(self, password: str) -> bool:
        if len(password) < 8:
            return False

        has_lower = any(c.islower() for c in password)
        has_upper = any(c.isupper() for c in password)
        has_digit = any(c.isdigit() for c in password)
        has_special = any(c in "!@#$%^&*()-+" for c in password)

        if not (has_lower and has_upper and has_digit and has_special):
            return False

        if any(password[i] == password[i + 1] for i in range(len(password) - 1)):
            return False

        return True