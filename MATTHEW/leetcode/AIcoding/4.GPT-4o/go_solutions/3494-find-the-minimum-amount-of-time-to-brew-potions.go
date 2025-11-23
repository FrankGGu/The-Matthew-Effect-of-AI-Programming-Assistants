func minTimeToBrew(potions []int, time int) int {
    max := 0
    for _, potion := range potions {
        if potion > max {
            max = potion
        }
    }
    return max * time
}