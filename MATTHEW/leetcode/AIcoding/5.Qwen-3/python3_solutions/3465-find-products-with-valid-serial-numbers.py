class Solution:
    def findProducts(self, products: List[str]) -> List[str]:
        result = []
        for product in products:
            if len(product) < 5:
                continue
            if product[0] != 'P':
                continue
            if not product[1].isdigit():
                continue
            if product[2] != 'S':
                continue
            if not product[3].isdigit():
                continue
            if not product[4].isdigit():
                continue
            result.append(product)
        return result