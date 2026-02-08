class Solution:
    def maxProduct(self, words: list[str]) -> int:
        masks = []
        for word in words:
            mask = 0
            for char in word:
                mask |= (1 << (ord(char) - ord('a')))
            masks.append((mask, len(word)))

        max_product = 0
        n = len(masks)

        for i in range(n):
            mask1, len1 = masks[i]
            for j in range(i + 1, n):
                mask2, len2 = masks[j]
                if (mask1 & mask2) == 0:
                    max_product = max(max_product, len1 * len2)

        return max_product