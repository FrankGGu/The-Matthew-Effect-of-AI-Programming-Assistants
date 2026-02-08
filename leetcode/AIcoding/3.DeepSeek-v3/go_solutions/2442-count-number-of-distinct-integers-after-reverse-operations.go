func countDistinctIntegers(nums []int) int {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
        reversed := 0
        n := num
        for n > 0 {
            reversed = reversed * 10 + n % 10
            n /= 10
        }
        seen[reversed] = true
    }
    return len(seen)
}