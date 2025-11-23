class Solution:
    def maxProduct(self, s: str) -> int:
        n = len(s)
        palindromes = {}

        for mask in range(1, 1 << n):
            subseq = []
            for i in range(n):
                if mask & (1 << i):
                    subseq.append(s[i])
            if subseq == subseq[::-1]:
                palindromes[mask] = len(subseq)

        max_product = 0
        masks = list(palindromes.keys())
        for i in range(len(masks)):
            for j in range(i + 1, len(masks)):
                if masks[i] & masks[j] == 0:
                    max_product = max(max_product, palindromes[masks[i]] * palindromes[masks[j]])

        return max_product