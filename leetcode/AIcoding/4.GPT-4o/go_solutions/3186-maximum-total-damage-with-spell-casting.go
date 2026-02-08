func maximumDamage(spells []int, potions []int, success int) int64 {
    maxDamage := int64(0)
    for _, spell := range spells {
        for _, potion := range potions {
            damage := int64(spell * potion)
            if damage <= int64(success) {
                maxDamage = max(maxDamage, damage)
            }
        }
    }
    return maxDamage
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}