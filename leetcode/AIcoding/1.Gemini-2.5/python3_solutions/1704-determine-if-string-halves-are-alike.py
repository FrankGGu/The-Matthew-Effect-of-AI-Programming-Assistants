class Solution:
    def halvesAreAlike(self, s: str) -> bool:
        n = len(s)
        mid = n // 2

        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}

        count_a = 0
        count_b = 0

        for i in range(mid):
            if s[i] in vowels:
                count_a += 1
            if s[mid + i] in vowels:
                count_b += 1

        return count_a == count_b