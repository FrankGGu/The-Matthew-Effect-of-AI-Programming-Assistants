class Cashier:

    def __init__(self, n: int, discount: int, products: list[int], prices: list[int]):
        self.n = n
        self.discount = discount
        self.products = products
        self.prices = prices
        self.product_price = {}
        for i in range(len(products)):
            self.product_price[products[i]] = prices[i]
        self.customer_count = 0

    def getBill(self, product: list[int], amount: list[int]) -> float:
        self.customer_count += 1
        total_price = 0
        for i in range(len(product)):
            total_price += self.product_price[product[i]] * amount[i]
        if self.customer_count % self.n == 0:
            total_price *= (1 - self.discount / 100)
        return total_price