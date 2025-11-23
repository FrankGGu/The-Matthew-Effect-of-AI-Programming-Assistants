func countLargestGroup(n int) int {
    sumMap := make(map[int]int)
    maxSize := 0
    count := 0

    for i := 1; i <= n; i++ {
        sum := 0
        num := i
        for num > 0 {
            sum += num % 10
            num /= 10
        }
        sumMap[sum]++
        if sumMap[sum] > maxSize {
            maxSize = sumMap[sum]
            count = 1
        } else if sumMap[sum] == maxSize {
            count++
        }
    }

    return count
}