from collections import defaultdict

def displayTable(orders):
    food_counts = defaultdict(lambda: defaultdict(int))
    tables = set()

    for name, table, food in orders:
        food_counts[food][table] += 1
        tables.add(table)

    sorted_foods = sorted(food_counts.keys())
    sorted_tables = sorted(tables, key=int)

    result = [["Table"] + sorted_foods]

    for table in sorted_tables:
        row = [table]
        for food in sorted_foods:
            row.append(str(food_counts[food][table]))
        result.append(row)

    return result