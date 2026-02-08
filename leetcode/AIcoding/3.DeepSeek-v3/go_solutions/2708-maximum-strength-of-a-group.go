func maxStrength(nums []int) int64 {
    if len(nums) == 1 {
        return int64(nums[0])
    }

    positives := []int{}
    negatives := []int{}
    hasZero := false

    for _, num := range nums {
        if num > 0 {
            positives = append(positives, num)
        } else if num < 0 {
            negatives = append(negatives, num)
        } else {
            hasZero = true
        }
    }

    maxPos := int64(1)
    for _, num := range positives {
        maxPos *= int64(num)
    }

    sort.Ints(negatives)
    maxNeg := int64(1)
    for i := 0; i < len(negatives); i++ {
        if i+1 < len(negatives) {
            maxNeg *= int64(negatives[i] * negatives[i+1])
            i++
        }
    }

    res := maxPos * maxNeg

    if res > 0 {
        return res
    } else if hasZero {
        return 0
    } else if len(positives) == 0 && len(negatives) == 1 {
        return int64(negatives[0])
    } else {
        return res
    }
}