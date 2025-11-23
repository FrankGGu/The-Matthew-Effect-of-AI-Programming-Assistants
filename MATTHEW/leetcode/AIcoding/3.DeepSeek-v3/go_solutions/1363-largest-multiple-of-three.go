func largestMultipleOfThree(digits []int) string {
    count := make([]int, 10)
    sum := 0
    for _, d := range digits {
        count[d]++
        sum += d
    }

    mod := sum % 3
    if mod != 0 {
        for i := mod; i < 10; i += 3 {
            if count[i] > 0 {
                count[i]--
                sum -= i
                mod = 0
                break
            }
        }
        if mod != 0 {
            need := 3 - mod
            removed := 0
            for i := need; i < 10 && removed < 2; i += 3 {
                for count[i] > 0 && removed < 2 {
                    count[i]--
                    sum -= i
                    removed++
                }
            }
            if removed != 2 {
                return ""
            }
        }
    }

    if sum == 0 {
        if count[0] > 0 {
            return "0"
        }
        return ""
    }

    var res strings.Builder
    for i := 9; i >= 0; i-- {
        for j := 0; j < count[i]; j++ {
            res.WriteByte(byte('0' + i))
        }
    }
    return res.String()
}