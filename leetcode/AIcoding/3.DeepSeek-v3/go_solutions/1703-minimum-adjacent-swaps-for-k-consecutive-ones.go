func minMoves(nums []int, k int) int {
    ones := []int{}
    for i, num := range nums {
        if num == 1 {
            ones = append(ones, i)
        }
    }

    n := len(ones)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + ones[i]
    }

    res := math.MaxInt32
    for i := 0; i <= n-k; i++ {
        left := i
        right := i + k - 1
        mid := (left + right) / 2
        radius := mid - left
        sum := ones[mid] * (radius + 1) - (prefix[mid+1] - prefix[left]) - radius*(radius+1)/2
        sum += (prefix[right+1] - prefix[mid+1]) - ones[mid]*(radius) - radius*(radius+1)/2
        if sum < res {
            res = sum
        }
    }

    return res
}