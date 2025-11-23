class Solution:
    def mirrorReflection(self, p: int, q: int) -> int:
        if (p // gcd(p, q)) % 2 == 0:
            return 2
        return 1 if (q // gcd(p, q)) % 2 == 0 else 0

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a