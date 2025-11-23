def min_damage(armor: int, damage: list[int]) -> int:
    max_damage = 0
    total_damage = 0
    for d in damage:
        total_damage += d
        max_damage = max(max_damage, d)

    reduced_damage = min(armor, max_damage)
    return total_damage - reduced_damage