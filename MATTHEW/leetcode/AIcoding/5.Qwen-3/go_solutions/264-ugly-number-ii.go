package main

type Ugly struct{}

func (u *Ugly) nthUglyNumber(n int) int {
    nums := make([]int, n)
    nums[0] = 1
    i2, i3, i5 := 0, 0, 0
    for i := 1; i < n; i++ {
        next2 := nums[i2] * 2
        next3 := nums[i3] * 3
        next5 := nums[i5] * 5
        next := min(min(next2, next3), next5)
        nums[i] = next
        if next == next2 {
            i2++
        }
        if next == next3 {
            i3++
        }
        if next == next5 {
            i5++
        }
    }
    return nums[n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}