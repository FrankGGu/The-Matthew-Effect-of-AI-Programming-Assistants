def mergeSimilarItems(items1, items2):
    from collections import defaultdict

    item_map = defaultdict(int)

    for item in items1:
        item_map[item[0]] += item[1]

    for item in items2:
        item_map[item[0]] += item[1]

    return sorted(item_map.items())