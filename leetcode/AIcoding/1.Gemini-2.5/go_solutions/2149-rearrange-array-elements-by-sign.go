func rearrangeArray(nums []int) []int {
    n := len(nums)
    result := make([]int, n)

    positives := make([]int, 0, n/2)
    negatives := make([]int, 0, n/2)

    for _, num := range nums {
        if num > 0 {
            positives = append(positives, num)
        } else {
            negatives = append(negatives, num)
        }
    }

    for i := 0; i < n/2; i++ {
        result[2*i] = positives[i]
        result[2*i+1] = negatives[i]
    }

    return result
}