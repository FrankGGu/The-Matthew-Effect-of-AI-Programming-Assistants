func minimumTotalCost(nums []int) int {
    n := len(nums)
    cost := 0
    count := make(map[int]int)

    for _, num := range nums {
        count[num]++
    }

    for _, num := range nums {
        if count[num] > 1 {
            for j := 1; j <= 100; j++ {
                if count[j] == 0 {
                    cost += j
                    count[j]++
                    count[num]--
                    break
                }
            }
        }
    }

    return cost
}