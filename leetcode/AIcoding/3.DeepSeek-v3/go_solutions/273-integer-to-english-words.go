func numberToWords(num int) string {
    if num == 0 {
        return "Zero"
    }

    units := []string{"", "Thousand", "Million", "Billion"}
    res := ""
    i := 0

    for num > 0 {
        part := num % 1000
        if part != 0 {
            res = helper(part) + " " + units[i] + " " + res
        }
        num /= 1000
        i++
    }

    return strings.TrimSpace(res)
}

func helper(num int) string {
    below20 := []string{"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"}
    tens := []string{"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"}

    if num == 0 {
        return ""
    } else if num < 20 {
        return below20[num]
    } else if num < 100 {
        return strings.TrimSpace(tens[num/10] + " " + helper(num%10))
    } else {
        return strings.TrimSpace(below20[num/100] + " Hundred " + helper(num%100))
    }
}