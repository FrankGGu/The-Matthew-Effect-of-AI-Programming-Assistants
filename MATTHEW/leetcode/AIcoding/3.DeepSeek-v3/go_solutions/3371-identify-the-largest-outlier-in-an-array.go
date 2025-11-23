func largestOutlier(nums []int) int {
    if len(nums) < 2 {
        return -1
    }

    even, odd := []int{}, []int{}
    for _, num := range nums {
        if num % 2 == 0 {
            even = append(even, num)
        } else {
            odd = append(odd, num)
        }
    }

    if len(even) == 1 {
        max := even[0]
        for _, num := range even {
            if num > max {
                max = num
            }
        }
        return max
    } else if len(odd) == 1 {
        max := odd[0]
        for _, num := range odd {
            if num > max {
                max = num
            }
        }
        return max
    } else {
        return -1
    }
}