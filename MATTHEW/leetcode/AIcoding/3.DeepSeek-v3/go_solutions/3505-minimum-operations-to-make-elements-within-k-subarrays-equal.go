func minOperations(nums []int, k int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    res := 0
    for num, cnt := range freq {
        if num < k {
            res += cnt
        }
    }
    return res
}