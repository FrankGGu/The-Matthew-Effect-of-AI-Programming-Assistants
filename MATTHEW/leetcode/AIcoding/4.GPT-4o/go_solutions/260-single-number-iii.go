func singleNumber(nums []int) []int {
    xor := 0
    for _, num := range nums {
        xor ^= num
    }

    diff := xor & -xor

    result := []int{0, 0}
    for _, num := range nums {
        if num & diff == 0 {
            result[0] ^= num
        } else {
            result[1] ^= num
        }
    }

    return result
}