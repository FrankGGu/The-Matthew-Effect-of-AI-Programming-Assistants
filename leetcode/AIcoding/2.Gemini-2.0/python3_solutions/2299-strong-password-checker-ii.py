class Solution:
    def strongPasswordCheckerII(self, password: str) -> bool:
        if len(password) < 8:
            return False

        has_lower = False
        has_upper = False
        has_digit = False
        has_special = False

        special_chars = "!@#$%^&*()-+"

        for char in password:
            if 'a' <= char <= 'z':
                has_lower = True
            elif 'A' <= char <= 'Z':
                has_upper = True
            elif '0' <= char <= '9':
                has_digit = True
            elif char in special_chars:
                has_special = True

        if not (has_lower and has_upper and has_digit and has_special):
            return False

        for i in range(len(password) - 1):
            if password[i] == password[i+1]:
                return False

        return True