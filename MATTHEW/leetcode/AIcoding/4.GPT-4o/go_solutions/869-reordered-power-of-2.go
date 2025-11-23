import (
    "sort"
    "strconv"
)

func reorderedPowerOf2(N int) bool {
    count := make([]int, 10)
    for _, digit := range strconv.Itoa(N) {
        count[digit-'0']++
    }

    for i := 0; i < 31; i++ {
        powerOf2 := 1 << i
        tempCount := make([]int, 10)
        for _, digit := range strconv.Itoa(powerOf2) {
            tempCount[digit-'0']++
        }
        if equalCount(count, tempCount) {
            return true
        }
    }
    return false
}

func equalCount(a, b []int) bool {
    for i := 0; i < 10; i++ {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}