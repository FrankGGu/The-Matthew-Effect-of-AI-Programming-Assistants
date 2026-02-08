package main

func maxIceCream(costs []int, coins int) int {
    if len(costs) == 0 {
        return 0
    }
    sort.Ints(costs)
    count := 0
    for _, cost := range costs {
        if coins >= cost {
            coins -= cost
            count++
        } else {
            break
        }
    }
    return count
}