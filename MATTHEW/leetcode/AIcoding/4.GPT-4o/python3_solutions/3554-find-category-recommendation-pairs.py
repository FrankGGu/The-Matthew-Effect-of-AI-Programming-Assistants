def recommendedProducts(self, products: List[str], searchWord: str) -> List[List[str]]:
    products.sort()
    result = []
    prefix = ""

    for char in searchWord:
        prefix += char
        result.append([])
        for product in products:
            if product.startswith(prefix):
                result[-1].append(product)
                if len(result[-1]) == 3:
                    break

    return result