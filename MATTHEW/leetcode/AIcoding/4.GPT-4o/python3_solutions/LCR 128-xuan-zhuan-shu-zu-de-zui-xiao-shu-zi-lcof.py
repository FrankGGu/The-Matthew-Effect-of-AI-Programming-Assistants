class Solution:
    def checkInventory(self, inventory: List[int], orders: List[int]) -> bool:
        from collections import Counter

        inventory_count = Counter(inventory)
        orders_count = Counter(orders)

        for item, count in orders_count.items():
            if inventory_count[item] < count:
                return False

        return True