class Solution:
    def countBeautifulSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        vowels = {'a', 'e', 'i', 'o', 'u'}
        beautiful_count = 0

        for i in range(n):
            v_count = 0
            c_count = 0
            for j in range(i, n):
                if s[j] in vowels:
                    v_count += 1
                else:
                    c_count += 1

                if v_count == c_count:
                    if (v_count * c_count) % k == 0:
                        beautiful_count += 1
        return beautiful_count