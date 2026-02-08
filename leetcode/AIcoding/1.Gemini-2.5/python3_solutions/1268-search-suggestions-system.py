import bisect

class Solution:
    def suggestedProducts(self, products: list[str], searchWord: str) -> list[list[str]]:
        products.sort()

        result = []
        prefix = ""

        for char in searchWord:
            prefix += char

            start_idx = bisect.bisect_left(products, prefix)

            current_suggestions = []
            for j in range(start_idx, min(start_idx + 3, len(products))):
                if products[j].startswith(prefix):
                    current_suggestions.append(products[j])
                else:
                    break

            result.append(current_suggestions)

        return result