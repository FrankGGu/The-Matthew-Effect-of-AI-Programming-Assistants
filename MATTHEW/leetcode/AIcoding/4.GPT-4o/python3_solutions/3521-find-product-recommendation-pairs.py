class Solution:
    def findPairs(self, products: List[List[int]], target: int) -> List[List[int]]:
        product_set = set()
        result = set()
        for product in products:
            product_set.add(product[0])

        for product in products:
            needed_product = target - product[0]
            if needed_product in product_set:
                result.add(tuple(sorted((product[0], needed_product))))

        return [list(pair) for pair in result]