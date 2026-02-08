from collections import defaultdict

class Solution:
    def displayTable(self, orders: list[list[str]]) -> list[list[str]]:
        food_items = set()
        tables = set()
        order_map = defaultdict(lambda: defaultdict(int))

        for order in orders:
            table_num = int(order[1])
            food_item = order[2]
            food_items.add(food_item)
            tables.add(table_num)
            order_map[table_num][food_item] += 1

        food_items = sorted(list(food_items))
        tables = sorted(list(tables))

        result = [["Table"]] + food_items

        for table_num in tables:
            row = [str(table_num)]
            for food_item in food_items:
                row.append(str(order_map[table_num][food_item]))
            result.append(row)

        return result