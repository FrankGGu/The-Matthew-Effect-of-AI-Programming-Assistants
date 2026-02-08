func singleNumber(nums []int) []int {
    seenOnce, seenTwice := 0, 0
    for _, num := range nums {
        seenOnce = (seenOnce ^ num) &^ seenTwice
        seenTwice = (seenTwice ^ num) &^ seenOnce
    }
    result := []int{}
    for _, num := range nums {
        if seenOnce == num {
            result = append(result, num)
        }
    }
    return result
}