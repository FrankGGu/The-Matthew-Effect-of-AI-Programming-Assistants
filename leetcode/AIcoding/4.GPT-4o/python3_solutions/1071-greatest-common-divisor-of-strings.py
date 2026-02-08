class Solution:
    def gcdOfStrings(self, str1: str, str2: str) -> str:
        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        def gcdString(x, y):
            if x + y != y + x:
                return ""
            return x[:gcd(len(x), len(y))]

        return gcdString(str1, str2)