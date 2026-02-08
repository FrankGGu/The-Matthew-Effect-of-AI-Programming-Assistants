class Solution:
    def suggestedProducts(self, products: List[str], searchWord: str) -> List[List[str]]:
        products.sort()
        res = []
        prefix = ""
        l, r = 0, len(products) - 1
        for char in searchWord:
            prefix += char
            left = l
            while l <= r and not products[l].startswith(prefix):
                l += 1
            while l <= r and not products[r].startswith(prefix):
                r -= 1

            suggestions = []
            for i in range(l, min(l + 3, r + 1)):
                suggestions.append(products[i])
            res.append(suggestions)
        return res