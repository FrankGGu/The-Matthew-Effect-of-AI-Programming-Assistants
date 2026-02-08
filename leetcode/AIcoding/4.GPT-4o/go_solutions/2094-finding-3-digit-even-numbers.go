func findEvenNumbers(digits []int) []int {
    count := make([]int, 10)
    for _, d := range digits {
        count[d]++
    }

    var result []int
    for i := 1; i < 10; i++ {
        if count[i] > 0 {
            for j := 0; j < 10; j++ {
                if count[j] > 0 && j%2 == 0 {
                    for k := 0; k < 10; k++ {
                        if count[k] > 0 {
                            if i == j && j == k && count[j] < 3 {
                                continue
                            }
                            if i == j && count[j] < 2 {
                                continue
                            }
                            if j == k && count[j] < 2 {
                                continue
                            }
                            num := i*100 + j*10 + k
                            result = append(result, num)
                        }
                    }
                }
            }
        }
    }

    sort.Ints(result)
    return result
}