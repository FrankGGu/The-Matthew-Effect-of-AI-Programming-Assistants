class Cashier:

    def __init__(self, n: int, discount: int, products: List[int], prices: List[int]):
        self.n = n
        self.discount = discount
        self.products = products
        self.prices = prices
        self.count = 0
        self.product_price_map = dict(zip(products, prices))

    def getBill(self, items: List[int]) -> float:
        self.count += 1
        total = 0
        for item in items:
            total += self.product_price_map[item]
        if self.count % self.n == 0:
            total *= (100 - self.discount) / 100
        return total