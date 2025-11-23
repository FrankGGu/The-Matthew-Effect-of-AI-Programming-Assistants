package main

func convertDateToBinary(date string) string {
    var day, month, year int
    fmt.Sscanf(date, "%d-%d-%d", &day, &month, &year)

    return decimalToBinary(day) + "-" + decimalToBinary(month) + "-" + decimalToBinary(year)
}

func decimalToBinary(n int) string {
    if n == 0 {
        return "0"
    }
    var res string
    for n > 0 {
        if n%2 == 1 {
            res = "1" + res
        } else {
            res = "0" + res
        }
        n /= 2
    }
    return res
}