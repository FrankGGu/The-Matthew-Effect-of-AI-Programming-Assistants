package main

func componentValue(nums []int, k int) int {
    total := 0
    for _, num := range nums {
        total += num
    }

    for i := total / k; i >= 1; i-- {
        if total%i == 0 {
            count := 0
            current := 0
            for _, num := range nums {
                current += num
                if current > i {
                    break
                }
                if current == i {
                    count++
                    current = 0
                }
            }
            if current == 0 {
                return count
            }
        }
    }
    return 0
}