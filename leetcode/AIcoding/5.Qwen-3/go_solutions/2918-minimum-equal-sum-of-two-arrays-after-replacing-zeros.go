package main

func minEqualSum(arr1 []int, arr2 []int) int {
    sum1 := 0
    sum2 := 0
    count1 := 0
    count2 := 0

    for _, num := range arr1 {
        if num == 0 {
            count1++
        } else {
            sum1 += num
        }
    }

    for _, num := range arr2 {
        if num == 0 {
            count2++
        } else {
            sum2 += num
        }
    }

    if sum1 > sum2 {
        if count2 == 0 {
            return -1
        }
        return sum1 + count2*1
    } else if sum2 > sum1 {
        if count1 == 0 {
            return -1
        }
        return sum2 + count1*1
    } else {
        return sum1
    }
}