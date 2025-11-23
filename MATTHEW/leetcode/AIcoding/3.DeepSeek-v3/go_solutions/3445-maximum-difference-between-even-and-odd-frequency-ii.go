func maxDiffBetweenEvenAndOddFrequency(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    maxEven := -1
    minOdd := -1
    for _, count := range freq {
        if count%2 == 0 {
            if count > maxEven || maxEven == -1 {
                maxEven = count
            }
        } else {
            if count < minOdd || minOdd == -1 {
                minOdd = count
            }
        }
    }
    if maxEven == -1 || minOdd == -1 {
        return 0
    }
    return maxEven - minOdd
}