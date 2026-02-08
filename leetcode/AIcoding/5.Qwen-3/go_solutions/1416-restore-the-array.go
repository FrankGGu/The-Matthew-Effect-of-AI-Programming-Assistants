package main

func numberToWord(num int) string {
    if num == 0 {
        return "Zero"
    }
    var res []string
    if num >= 1000000000 {
        res = append(res, numberToWord(num/1000000000)+" Billion")
        num %= 1000000000
    }
    if num >= 1000000 {
        res = append(res, numberToWord(num/1000000)+" Million")
        num %= 1000000
    }
    if num >= 1000 {
        res = append(res, numberToWord(num/1000)+" Thousand")
        num %= 1000
    }
    if num > 0 {
        if num < 20 {
            res = append(res, oneToNineteen[num])
        } else if num < 100 {
            res = append(res, tens[num/10])
            if num%10 > 0 {
                res = append(res, oneToNineteen[num%10])
            }
        } else {
            res = append(res, oneToNineteen[num/100]+" Hundred")
            if num%100 > 0 {
                if num%100 < 20 {
                    res = append(res, oneToNineteen[num%100])
                } else {
                    res = append(res, tens[(num%100)/10])
                    if num%10 > 0 {
                        res = append(res, oneToNineteen[num%10])
                    }
                }
            }
        }
    }
    return strings.Join(res, " ")
}

var oneToNineteen = []string{
    "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
    "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
    "Seventeen", "Eighteen", "Nineteen",
}

var tens = []string{
    "", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety",
}