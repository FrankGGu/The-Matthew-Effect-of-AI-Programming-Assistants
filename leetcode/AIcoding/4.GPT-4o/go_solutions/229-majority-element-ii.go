func majorityElement(nums []int) []int {
    if len(nums) == 0 {
        return []int{}
    }

    candidate1, candidate2, count1, count2 := 0, 0, 0, 0

    for _, num := range nums {
        if num == candidate1 {
            count1++
        } else if num == candidate2 {
            count2++
        } else if count1 == 0 {
            candidate1, count1 = num, 1
        } else if count2 == 0 {
            candidate2, count2 = num, 1
        } else {
            count1--
            count2--
        }
    }

    count1, count2 = 0, 0
    for _, num := range nums {
        if num == candidate1 {
            count1++
        } else if num == candidate2 {
            count2++
        }
    }

    result := []int{}
    if count1 > len(nums)/3 {
        result = append(result, candidate1)
    }
    if count2 > len(nums)/3 {
        result = append(result, candidate2)
    }

    return result
}