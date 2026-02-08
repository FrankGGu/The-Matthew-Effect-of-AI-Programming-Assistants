class Solution:
    def smallestPalindromic(self, num: str) -> str:
        from collections import Counter

        count = Counter(num)
        odd_count = sum(1 for v in count.values() if v % 2 != 0)
        if odd_count > 1 or (odd_count == 1 and '0' in count):
            return ""

        half = []
        middle = ""

        for k in sorted(count.keys()):
            if count[k] % 2 == 1:
                middle = k
            half.append(k * (count[k] // 2))

        half_str = ''.join(half)
        if not half_str and middle:
            return middle

        palindrome = half_str + middle + half_str[::-1]
        return palindrome.lstrip('0') or "0"