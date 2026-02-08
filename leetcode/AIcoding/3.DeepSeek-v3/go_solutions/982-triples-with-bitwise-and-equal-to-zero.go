func countTriplets(nums []int) int {
    count := 0
    freq := make(map[int]int)
    for _, a := range nums {
        for _, b := range nums {
            freq[a & b]++
        }
    }
    for _, c := range nums {
        for ab, cnt := range freq {
            if ab & c == 0 {
                count += cnt
            }
        }
    }
    return count
}