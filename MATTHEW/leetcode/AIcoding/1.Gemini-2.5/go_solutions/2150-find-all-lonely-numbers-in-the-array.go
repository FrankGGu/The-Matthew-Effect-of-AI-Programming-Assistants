func findLonely(nums []int) []int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    var lonelyNumbers []int
    for _, num := range nums {
        if freq[num] == 1 {
            _, hasPrev := freq[num-1]
            _, hasNext := freq[num+1]

            if !hasPrev && !hasNext {
                lonelyNumbers = append(lonelyNumbers, num)
            }
        }
    }

    return lonelyNumbers
}