class Solution:
    def maxProduct(self, words: List[str]) -> int:
        masks = []
        for word in words:
            mask = 0
            for c in word:
                mask |= 1 << (ord(c) - ord('a'))
            masks.append(mask)

        max_prod = 0
        n = len(words)
        for i in range(n):
            for j in range(i + 1, n):
                if (masks[i] & masks[j]) == 0:
                    max_prod = max(max_prod, len(words[i]) * len(words[j]))
        return max_prod