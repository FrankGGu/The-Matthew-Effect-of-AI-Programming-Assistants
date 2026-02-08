class Cashier:

    def __init__(self, n: int, discount: int, products: List[int], prices: List[int]):
        self.n = n
        self.discount = discount
        self.product_prices = {product: price for product, price in zip(products, prices)}
        self.customer_count = 0

    def getBill(self, product: List[int], amount: List[int]) -> float:
        self.customer_count += 1
        total = 0.0
        for p, a in zip(product, amount):
            total += self.product_prices[p] * a

        if self.customer_count % self.n == 0:
            total = total * (100 - self.discount) / 100

        return total