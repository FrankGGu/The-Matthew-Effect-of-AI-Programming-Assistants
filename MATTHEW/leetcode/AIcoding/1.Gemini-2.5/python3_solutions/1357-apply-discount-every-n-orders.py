class Cashier:

    def __init__(self, n: int, discount: int, products: list[int], prices: list[int]):
        self.n = n
        self.discount_factor = 1 - (discount / 100.0)
        self.customer_count = 0
        self.product_prices = {}
        for i in range(len(products)):
            self.product_prices[products[i]] = prices[i]

    def getBill(self, product: list[int], amount: list[int]) -> float:
        self.customer_count += 1
        current_bill = 0.0

        for i in range(len(product)):
            product_id = product[i]
            quantity = amount[i]
            current_bill += self.product_prices[product_id] * quantity

        if self.customer_count % self.n == 0:
            current_bill *= self.discount_factor

        return current_bill