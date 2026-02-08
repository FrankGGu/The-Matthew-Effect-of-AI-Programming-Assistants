func checkInventory(orders [][]int, inventory []int) []int {
    for _, order := range orders {
        for i := order[0]; i <= order[1]; i++ {
            if inventory[i] > 0 {
                inventory[i]--
            }
        }
    }
    return inventory
}