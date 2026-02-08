func makeSimilar(nums []int, target []int) int64 {
    sort.Ints(nums)
    sort.Ints(target)

    var oddNums, evenNums []int
    var oddTarget, evenTarget []int

    for _, num := range nums {
        if num%2 == 0 {
            evenNums = append(evenNums, num)
        } else {
            oddNums = append(oddNums, num)
        }
    }

    for _, t := range target {
        if t%2 == 0 {
            evenTarget = append(evenTarget, t)
        } else {
            oddTarget = append(oddTarget, t)
        }
    }

    var res int64
    for i := 0; i < len(oddNums); i++ {
        diff := oddNums[i] - oddTarget[i]
        if diff > 0 {
            res += int64(diff / 2)
        }
    }

    for i := 0; i < len(evenNums); i++ {
        diff := evenNums[i] - evenTarget[i]
        if diff > 0 {
            res += int64(diff / 2)
        }
    }

    return res
}