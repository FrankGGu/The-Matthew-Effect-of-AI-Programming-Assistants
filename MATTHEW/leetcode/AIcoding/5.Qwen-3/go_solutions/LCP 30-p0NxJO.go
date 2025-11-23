package main

func magicTower(nums []int) int {
    var health, gold int
    health = 1
    gold = 0
    for _, num := range nums {
        if num > 0 {
            health += num
            gold += num
        } else {
            if health+num <= 0 {
                return -1
            }
            health += num
            gold += num
        }
    }
    return gold
}