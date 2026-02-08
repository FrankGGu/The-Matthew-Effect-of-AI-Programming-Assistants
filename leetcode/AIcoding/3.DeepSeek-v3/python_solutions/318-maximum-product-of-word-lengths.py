class Solution:
    def maxProduct(self, words: List[str]) -> int:
        masks = []
        for word in words:
            mask = 0
            for c in word:
                mask |= 1 << (ord(c) - ord('a'))
            masks.append(mask)

        max_product = 0
        n = len(words)
        for i in range(n):
            for j in range(i + 1, n):
                if (masks[i] & masks[j]) == 0:
                    product = len(words[i]) * len(words[j])
                    if product > max_product:
                        max_product = product
        return max_product