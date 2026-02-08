func rearrangeArray(nums []int) []int {
    positive, negative := []int{}, []int{}
    for _, num := range nums {
        if num > 0 {
            positive = append(positive, num)
        } else {
            negative = append(negative, num)
        }
    }

    result := make([]int, len(nums))
    for i := 0; i < len(result)/2; i++ {
        result[2*i] = positive[i]
        result[2*i+1] = negative[i]
    }

    return result
}