func majorityElement(nums []int) int {
    count := 0
    var candidate int

    for _, num := range nums {
        if count == 0 {
            candidate = num
        }
        if num == candidate {
            count++
        } else {
            count--
        }
    }

    return candidate
}