func canArrange(arr []int, k int) bool {
    remainderCount := make([]int, k)

    for _, num := range arr {
        remainderCount[(num % k + k) % k]++
    }

    for i := 1; i < (k+1)/2; i++ {
        if remainderCount[i] != remainderCount[k-i] {
            return false
        }
    }

    return remainderCount[0]%2 == 0
}