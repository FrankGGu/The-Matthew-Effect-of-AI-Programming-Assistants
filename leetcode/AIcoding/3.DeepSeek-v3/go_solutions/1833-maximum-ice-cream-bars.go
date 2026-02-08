import "sort"

func maxIceCream(costs []int, coins int) int {
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