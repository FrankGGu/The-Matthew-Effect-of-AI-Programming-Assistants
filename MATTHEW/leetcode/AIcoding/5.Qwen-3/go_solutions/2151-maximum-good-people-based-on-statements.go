package main

func maxGood(people [][]int) int {
    n := len(people)
    maxGood := 0

    for mask := 1; mask < 1<<n; mask++ {
        valid := true
        for i := 0; i < n && valid; i++ {
            if (mask & (1 << i)) == 0 {
                continue
            }
            for j := 0; j < n; j++ {
                if i == j {
                    continue
                }
                if people[i][j] == 1 && (mask & (1 << j)) == 0 {
                    valid = false
                    break
                }
                if people[i][j] == 0 && (mask & (1 << j)) != 0 {
                    valid = false
                    break
                }
            }
        }
        if valid {
            count := 0
            for i := 0; i < n; i++ {
                if mask & (1 << i) != 0 {
                    count++
                }
            }
            if count > maxGood {
                maxGood = count
            }
        }
    }

    return maxGood
}