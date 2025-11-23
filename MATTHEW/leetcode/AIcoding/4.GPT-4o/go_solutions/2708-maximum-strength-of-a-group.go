func maxStrength(nums []int) int {
    positive := []int{}
    negative := []int{}
    zeroCount := 0

    for _, num := range nums {
        if num > 0 {
            positive = append(positive, num)
        } else if num < 0 {
            negative = append(negative, num)
        } else {
            zeroCount++
        }
    }

    if len(negative)%2 != 0 {
        sort.Ints(negative)
        negative = negative[:len(negative)-1]
    }

    product := 1
    for _, num := range positive {
        product *= num
    }

    for _, num := range negative {
        product *= num
    }

    if product == 1 && zeroCount > 0 {
        return 0
    }

    return product
}