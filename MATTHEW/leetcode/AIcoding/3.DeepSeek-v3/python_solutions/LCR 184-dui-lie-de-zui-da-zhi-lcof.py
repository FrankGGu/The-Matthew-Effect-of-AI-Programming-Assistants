class Checkout:
    def __init__(self):
        self.items = []
        self.discounts = {
            'A': {'quantity': 3, 'price': 75},
            'B': {'quantity': 2, 'price': 35}
        }
        self.prices = {
            'A': 50,
            'B': 30,
            'C': 20,
            'D': 15
        }

    def scan(self, item: str) -> None:
        self.items.append(item)

    def total(self) -> int:
        total = 0
        item_counts = {}
        for item in self.items:
            item_counts[item] = item_counts.get(item, 0) + 1

        for item, count in item_counts.items():
            if item in self.discounts:
                discount = self.discounts[item]
                discount_quantity = discount['quantity']
                discount_price = discount['price']
                num_discounts = count // discount_quantity
                remaining = count % discount_quantity
                total += num_discounts * discount_price + remaining * self.prices[item]
            else:
                total += count * self.prices[item]

        return total