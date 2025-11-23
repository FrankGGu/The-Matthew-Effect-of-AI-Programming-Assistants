class Solution:
    def dynamicPassword(self, password: str, shift: int) -> str:
        n = len(password)
        shift %= n
        return password[n - shift:] + password[:n - shift]