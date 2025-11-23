class Solution:
    def suggestedProducts(self, products: List[str], searchWord: str) -> List[List[str]]:
        products.sort()
        res = []
        for i in range(len(searchWord)):
            prefix = searchWord[:i+1]
            temp = []
            for product in products:
                if product.startswith(prefix):
                    temp.append(product)
                    if len(temp) == 3:
                        break
            res.append(temp)
        return res