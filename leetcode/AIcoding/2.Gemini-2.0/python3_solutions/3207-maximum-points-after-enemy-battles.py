def maxPoints(enemies: list[int], points: list[int], armor: int) -> int:
    n = len(enemies)
    total_points = 0
    max_enemy = 0
    for enemy in enemies:
        max_enemy = max(max_enemy, enemy)

    for i in range(n):
        if enemies[i] < armor:
            total_points += points[i]
        else:
            total_points += points[i]

    if max_enemy > armor:
        max_index = -1
        for i in range(n):
            if enemies[i] == max_enemy:
                max_index = i
                break

        temp_total = 0
        for i in range(n):
            if i == max_index:
                temp_enemy = max(0, enemies[i] - armor)
                temp_total += points[i] * (temp_enemy < enemies[i])
            else:
                temp_total += points[i]

        return total_points
    else:

        temp_total = 0

        temp_total2 = 0
        for i in range(n):
            temp_total2 += points[i]

        return temp_total2