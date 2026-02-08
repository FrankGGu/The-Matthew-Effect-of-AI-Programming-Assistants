class Solution:
    def maxProduct(self, words: List[str]) -> int:
        bit_masks = []
        for word in words:
            bit_mask = 0
            for char in set(word):
                bit_mask |= 1 << (ord(char) - ord('a'))
            bit_masks.append(bit_mask)

        max_product = 0
        n = len(words)
        for i in range(n):
            for j in range(i + 1, n):
                if bit_masks[i] & bit_masks[j] == 0:
                    max_product = max(max_product, len(words[i]) * len(words[j]))

        return max_product