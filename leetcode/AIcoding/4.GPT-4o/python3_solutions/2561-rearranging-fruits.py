def rearrangeFruits(fruits):
    from collections import Counter
    count = Counter(fruits)
    max_count = max(count.values())
    result = []

    for fruit, cnt in count.items():
        if cnt == max_count:
            result.append(fruit)

    return result