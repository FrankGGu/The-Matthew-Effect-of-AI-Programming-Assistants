package main

func findValidSplit(n int, nums []int) int {
    left := make(map[int]int)
    right := make(map[int]int)

    for i := 0; i < n; i++ {
        num := nums[i]
        for j := 2; j*j <= num; j++ {
            for ; num%j == 0; num /= j {
                right[j]++
            }
        }
        if num > 1 {
            right[num]++
        }
    }

    for i := 0; i < n; i++ {
        num := nums[i]
        for j := 2; j*j <= num; j++ {
            for ; num%j == 0; num /= j {
                left[j]++
                right[j]--
            }
        }
        if num > 1 {
            left[num]++
            right[num]--
        }

        valid := true
        for p := range left {
            if right[p] > 0 {
                valid = false
                break
            }
        }

        if valid {
            return i
        }
    }

    return n - 1
}