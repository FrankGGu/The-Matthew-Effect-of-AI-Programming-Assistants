class Solution:
    def maxRepOpt1(self, text: str) -> int:
        count = {}
        for char in text:
            count[char] = count.get(char, 0) + 1

        max_len = 0
        n = len(text)

        for i in range(n):
            char = text[i]
            j = i

            while j < n and text[j] == char:
                j += 1

            length = j - i
            max_len = max(max_len, min(length + 1, count[char]))

            if j < n:
                next_char = text[j]
                if next_char != char:
                    k = j
                    while k < n and text[k] == next_char:
                        k += 1
                    max_len = max(max_len, min(length + (k - j) + 1, count[char]))

            i = j - 1

        return max_len