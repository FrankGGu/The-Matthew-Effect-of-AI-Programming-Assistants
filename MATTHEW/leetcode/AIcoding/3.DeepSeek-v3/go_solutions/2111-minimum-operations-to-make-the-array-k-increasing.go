func kIncreasing(arr []int, k int) int {
    n := len(arr)
    res := 0
    for i := 0; i < k; i++ {
        var sub []int
        for j := i; j < n; j += k {
            sub = append(sub, arr[j])
        }
        res += len(sub) - lengthOfLIS(sub)
    }
    return res
}

func lengthOfLIS(nums []int) int {
    tails := make([]int, 0)
    for _, num := range nums {
        idx := sort.Search(len(tails), func(i int) bool {
            return tails[i] > num
        })
        if idx == len(tails) {
            tails = append(tails, num)
        } else {
            tails[idx] = num
        }
    }
    return len(tails)
}