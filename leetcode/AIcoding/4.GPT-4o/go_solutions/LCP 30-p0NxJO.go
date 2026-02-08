func magicTower(nums []int) bool {
    totalHealth := 1
    currentHealth := 1
    deficit := 0

    for _, num := range nums {
        totalHealth += num
        if totalHealth <= 0 {
            deficit += -totalHealth + 1
            totalHealth = 1
        }
    }

    return currentHealth + deficit > 0
}