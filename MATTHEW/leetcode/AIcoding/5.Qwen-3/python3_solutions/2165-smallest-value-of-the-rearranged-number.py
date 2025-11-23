class Solution:
    def minimumInteger(self, n: str) -> int:
        from collections import Counter

        count = Counter(n)
        digits = sorted(count.elements())
        for i in range(len(digits)):
            if digits[i] != '0':
                digits[0], digits[i] = digits[i], digits[0]
                break
        return int(''.join(digits))