func unequalTriplets(nums []int) int {
    count := 0
    freq := make(map[int]int)

    for _, num := range nums {
        freq[num]++
    }

    uniqueNums := []int{}
    for num := range freq {
        uniqueNums = append(uniqueNums, num)
    }

    n := len(uniqueNums)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            for k := j + 1; k < n; k++ {
                count += freq[uniqueNums[i]] * freq[uniqueNums[j]] * freq[uniqueNums[k]]
            }
        }
    }

    return count
}