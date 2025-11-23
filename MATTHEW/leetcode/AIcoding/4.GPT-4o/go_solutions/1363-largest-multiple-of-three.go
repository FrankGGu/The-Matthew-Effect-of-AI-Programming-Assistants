func largestMultipleOfThree(digits []int) string {
    count := make([]int, 3)
    for _, digit := range digits {
        count[digit%3]++
    }

    total := 0
    for _, digit := range digits {
        total += digit
    }

    remainder := total % 3
    if remainder != 0 {
        if count[remainder] > 0 {
            count[remainder]--
        } else {
            if count[3-remainder] >= 2 {
                count[3-remainder] -= 2
            } else {
                return ""
            }
        }
    }

    result := []int{}
    for i := 9; i >= 0; i-- {
        if count[i%3] > 0 {
            for j := 0; j < count[i%3]; j++ {
                result = append(result, i)
            }
        }
    }

    if len(result) == 0 {
        return "0"
    }

    sort.Sort(sort.Reverse(sort.IntSlice(result)))
    return strings.TrimLeft(strings.Join(strings.Fields(fmt.Sprint(result)), ""), "[]"), " ")
}