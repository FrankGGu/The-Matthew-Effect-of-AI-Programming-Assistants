func canThreePartsEqualSum(arr []int) bool {
    total := 0
    for _, num := range arr {
        total += num
    }
    if total%3 != 0 {
        return false
    }
    target := total / 3
    sum := 0
    count := 0
    for i := 0; i < len(arr); i++ {
        sum += arr[i]
        if sum == target {
            count++
            sum = 0
        }
        if count == 2 && i < len(arr)-1 {
            return true
        }
    }
    return false
}