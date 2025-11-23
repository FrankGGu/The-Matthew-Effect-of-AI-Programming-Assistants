func minOperations(nums []int) int {
    maxNum := 0
    ops := 0

    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
        ops += countOnes(num)
    }

    return ops + bitLength(maxNum) - 1
}

func countOnes(num int) int {
    count := 0
    for num > 0 {
        count += num & 1
        num >>= 1
    }
    return count
}

func bitLength(num int) int {
    length := 0
    for num > 0 {
        length++
        num >>= 1
    }
    return length
}