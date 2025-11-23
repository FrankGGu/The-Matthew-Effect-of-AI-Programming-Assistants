package main

func minimumOperations(nums []int) int {
    if len(nums) == 1 {
        return 0
    }

    count1 := make(map[int]int)
    count2 := make(map[int]int)

    for i, num := range nums {
        if i%2 == 0 {
            count1[num]++
        } else {
            count2[num]++
        }
    }

    var max1, max2 int
    var val1, val2 int

    for k, v := range count1 {
        if v > max1 {
            max1 = v
            val1 = k
        }
    }

    for k, v := range count2 {
        if v > max2 {
            max2 = v
            val2 = k
        }
    }

    if val1 != val2 {
        return len(nums) - max1 - max2
    }

    max1 = 0
    max2 = 0
    for k, v := range count1 {
        if k != val2 && v > max1 {
            max1 = v
        }
    }

    for k, v := range count2 {
        if k != val1 && v > max2 {
            max2 = v
        }
    }

    return len(nums) - max1 - max2
}