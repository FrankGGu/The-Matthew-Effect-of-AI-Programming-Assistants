func findNumbers(nums []int) int {
    count := 0
    for _, num := range nums {
        if (len(strconv.Itoa(num)) % 2) == 0 {
            count++
        }
    }
    return count
}