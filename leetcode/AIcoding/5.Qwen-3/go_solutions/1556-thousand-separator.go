package main

func digitsToWords(num int) string {
    if num == 0 {
        return "Zero"
    }

    var result []string

    if num >= 1000000000 {
        result = append(result, digitsToWords(num/1000000000)+" Billion")
        num %= 1000000000
    }

    if num >= 1000000 {
        result = append(result, digitsToWords(num/1000000)+" Million")
        num %= 1000000
    }

    if num >= 1000 {
        result = append(result, digitsToWords(num/1000)+" Thousand")
        num %= 1000
    }

    if num > 0 {
        if num < 20 {
            result = append(result, ones[num])
        } else if num < 100 {
            result = append(result, tens[num/10])
            if num%10 > 0 {
                result = append(result, ones[num%10])
            }
        } else {
            result = append(result, ones[num/100]+" Hundred")
            if num%100 > 0 {
                if num%100 < 20 {
                    result = append(result, ones[num%100])
                } else {
                    result = append(result, tens[(num%100)/10])
                    if num%10 > 0 {
                        result = append(result, ones[num%10])
                    }
                }
            }
        }
    }

    return strings.Join(result, " ")
}

var ones = []string{
    "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
    "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
    "Seventeen", "Eighteen", "Nineteen",
}

var tens = []string{
    "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety",
}