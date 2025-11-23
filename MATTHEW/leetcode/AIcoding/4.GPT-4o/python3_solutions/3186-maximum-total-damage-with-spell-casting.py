def maximumDamage(spells, potions, success):
    spells.sort(reverse=True)
    potions.sort(reverse=True)
    max_damage = 0

    for spell in spells:
        for potion in potions:
            if spell + potion <= success:
                max_damage = max(max_damage, spell * potion)
                break
    return max_damage