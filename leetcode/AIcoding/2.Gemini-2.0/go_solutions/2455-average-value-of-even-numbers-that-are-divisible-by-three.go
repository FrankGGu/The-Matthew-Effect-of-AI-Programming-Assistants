func average(nums []int) int {
    sum := 0
    count := 0
    for _, num := range nums {
        if num%2 == 0 && num%3 == 0 {
            sum += num
            count++
        }
    }
    if count == 0 {
        return 0
    }
    return sum / count
}