func numFriendRequests(ages []int) int {
    count := 0
    frequency := make([]int, 121)
    for _, age := range ages {
        frequency[age]++
    }

    for i := 1; i <= 120; i++ {
        if frequency[i] == 0 {
            continue
        }
        for j := 1; j <= 120; j++ {
            if frequency[j] == 0 {
                continue
            }
            if (j <= i/2 + 7) || (j > i) {
                continue
            }
            if i == j {
                count += frequency[i] * (frequency[j] - 1)
            } else {
                count += frequency[i] * frequency[j]
            }
        }
    }

    return count
}