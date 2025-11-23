class Cashier:

    def __init__(self, n: int, discount: int, products: List[int], prices: List[int]):
        self.n = n
        self.discount = discount
        self.product_price_map = dict(zip(products, prices))
        self.customer_count = 0

    def getBill(self, product: List[int], quantity: List[int]) -> float:
        self.customer_count += 1
        total = sum(self.product_price_map[product[i]] * quantity[i] for i in range(len(product)))
        if self.customer_count % self.n == 0:
            total *= (100 - self.discount) / 100
        return total