from collections import defaultdict

class Solution:
    def displayTable(self, orders: list[list[str]]) -> list[list[str]]:
        food_items = set()
        table_orders = defaultdict(lambda: defaultdict(int))
        table_numbers = set()

        for _, table_num_str, food_item in orders:
            table_num = int(table_num_str)
            food_items.add(food_item)
            table_numbers.add(table_num)
            table_orders[table_num][food_item] += 1

        sorted_food_items = sorted(list(food_items))
        sorted_table_numbers = sorted(list(table_numbers))

        result = [["Table"] + sorted_food_items]

        for table_num in sorted_table_numbers:
            row = [str(table_num)]
            for food_item in sorted_food_items:
                row.append(str(table_orders[table_num][food_item]))
            result.append(row)

        return result