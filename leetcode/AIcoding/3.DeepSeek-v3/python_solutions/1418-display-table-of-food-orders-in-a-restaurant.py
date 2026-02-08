class Solution:
    def displayTable(self, orders: List[List[str]]) -> List[List[str]]:
        food_items = set()
        table_numbers = set()
        table_food_count = {}

        for order in orders:
            _, table, food = order
            table = int(table)
            food_items.add(food)
            table_numbers.add(table)
            if table not in table_food_count:
                table_food_count[table] = {}
            table_food_count[table][food] = table_food_count[table].get(food, 0) + 1

        sorted_food_items = sorted(food_items)
        sorted_table_numbers = sorted(table_numbers)

        result = []
        header = ["Table"] + sorted_food_items
        result.append(header)

        for table in sorted_table_numbers:
            row = [str(table)]
            for food in sorted_food_items:
                count = table_food_count[table].get(food, 0)
                row.append(str(count))
            result.append(row)

        return result