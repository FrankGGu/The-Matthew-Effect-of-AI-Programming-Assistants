func countLargestGroup(n int) int {
    count := make(map[int]int)
    maxSize := 0

    for i := 1; i <= n; i++ {
        sum := 0
        num := i
        for num > 0 {
            sum += num % 10
            num /= 10
        }
        count[sum]++
        if count[sum] > maxSize {
            maxSize = count[sum]
        }
    }

    result := 0
    for _, c := range count {
        if c == maxSize {
            result++
        }
    }

    return result
}