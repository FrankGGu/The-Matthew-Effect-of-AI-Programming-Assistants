package main

func largestNumber(num int) int {
    s := []byte(strconv.Itoa(num))
    for i := 0; i < len(s); i++ {
        if (s[i] - '0')%2 == 0 {
            for j := len(s) - 1; j > i; j-- {
                if (s[j] - '0')%2 == 0 && s[j] > s[i] {
                    s[i], s[j] = s[j], s[i]
                    return parseInt(s)
                }
            }
        }
    }
    return parseInt(s)
}

func parseInt(s []byte) int {
    res, _ := strconv.Atoi(string(s))
    return res
}