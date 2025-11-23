class Solution:
    def maxRepOpt1(self, text: str) -> int:
        count = {}
        for c in text:
            count[c] = count.get(c, 0) + 1

        max_len = 0
        for i in range(len(text)):
            j = i
            while j < len(text) and text[j] == text[i]:
                j += 1

            orig_len = j - i

            if orig_len < count[text[i]]:

                k = j
                while k < len(text) and text[k] == text[i]:
                    k += 1

                max_len = max(max_len, min(count[text[i]], k - i))
            else:
                max_len = max(max_len, orig_len)

        return max_len