func findSmallestInteger(nums []int, value int) int {
    cnt := make(map[int]int)
    for _, num := range nums {
        cnt[((num % value) + value) % value]++
    }
    for i := 0; ; i++ {
        if cnt[i%value] == 0 {
            return i
        }
        cnt[i%value]--
    }
}