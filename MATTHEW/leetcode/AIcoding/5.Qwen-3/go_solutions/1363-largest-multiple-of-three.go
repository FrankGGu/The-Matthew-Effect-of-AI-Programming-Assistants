package main

func largestMultipleOfThree(digits []int) string {
    sort.Ints(digits)
    sum := 0
    for _, d := range digits {
        sum += d
    }
    if sum%3 == 0 {
        if len(digits) == 0 {
            return ""
        }
        if digits[len(digits)-1] == 0 {
            return "0"
        }
        sb := strings.Builder{}
        for i := len(digits) - 1; i >= 0; i-- {
            sb.WriteString(strconv.Itoa(digits[i]))
        }
        return sb.String()
    }
    var indices []int
    for i, d := range digits {
        if (sum - d) % 3 == 0 {
            indices = append(indices, i)
        }
    }
    if len(indices) == 0 {
        if sum%3 == 1 {
            for i, d := range digits {
                if d%3 == 1 {
                    indices = append(indices, i)
                    break
                }
            }
            if len(indices) == 0 {
                for i, d := range digits {
                    if d%3 == 2 {
                        indices = append(indices, i)
                        break
                    }
                }
                if len(indices) == 0 {
                    return ""
                }
            }
        } else {
            for i, d := range digits {
                if d%3 == 2 {
                    indices = append(indices, i)
                    break
                }
            }
            if len(indices) == 0 {
                for i, d := range digits {
                    if d%3 == 1 {
                        indices = append(indices, i)
                        break
                    }
                }
                if len(indices) == 0 {
                    return ""
                }
            }
        }
    }
    digits = append(digits[:indices[0]], digits[indices[0]+1:]...)
    if len(digits) == 0 {
        return ""
    }
    if digits[len(digits)-1] == 0 {
        return "0"
    }
    sb := strings.Builder{}
    for i := len(digits) - 1; i >= 0; i-- {
        sb.WriteString(strconv.Itoa(digits[i]))
    }
    return sb.String()
}