from collections import Counter
import math

def countAnagrams(s: str) -> int:
    words = s.split()
    n = len(words)
    MOD = 10**9 + 7

    def factorial(num):
        res = 1
        for i in range(1, num + 1):
            res = (res * i) % MOD
        return res

    def inverse(num):
        return pow(num, MOD - 2, MOD)

    total_len = sum(len(word) for word in words)

    numerator = factorial(total_len)
    denominator = 1

    for word in words:
        counts = Counter(word)
        for count in counts.values():
            denominator = (denominator * factorial(count)) % MOD

    result = (numerator * inverse(denominator)) % MOD

    return result