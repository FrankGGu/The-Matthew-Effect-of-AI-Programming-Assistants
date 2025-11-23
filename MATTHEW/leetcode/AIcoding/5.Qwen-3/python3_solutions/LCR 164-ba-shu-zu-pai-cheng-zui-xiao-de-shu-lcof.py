class Solution:
    def findPassword(self, secret: str, m: int, k: int) -> str:
        n = len(secret)
        password = []
        for i in range(n):
            if (i + 1) % m == 0:
                password.append(secret[i])
        return ''.join(password)