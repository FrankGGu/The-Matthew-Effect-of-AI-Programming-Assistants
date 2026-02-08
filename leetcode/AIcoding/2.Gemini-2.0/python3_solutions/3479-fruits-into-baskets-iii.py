def totalFruit(fruits):
    max_len = 0
    left = 0
    fruit_count = {}
    for right, fruit in enumerate(fruits):
        if fruit in fruit_count:
            fruit_count[fruit] += 1
        else:
            fruit_count[fruit] = 1

        while len(fruit_count) > 2:
            fruit_count[fruits[left]] -= 1
            if fruit_count[fruits[left]] == 0:
                del fruit_count[fruits[left]]
            left += 1

        max_len = max(max_len, right - left + 1)

    return max_len