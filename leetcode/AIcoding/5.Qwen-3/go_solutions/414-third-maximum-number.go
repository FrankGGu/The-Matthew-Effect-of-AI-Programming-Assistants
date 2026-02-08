package main

func thirdMaximumNumber(nums []int) int {
    var first, second, third *int
    for _, num := range nums {
        if first == nil || num > *first {
            third = second
            second = first
            first = &num
        } else if num != *first {
            if second == nil || num > *second {
                third = second
                second = &num
            } else if num != *second {
                if third == nil || num > *third {
                    third = &num
                }
            }
        }
    }
    if third != nil {
        return *third
    }
    return *first
}