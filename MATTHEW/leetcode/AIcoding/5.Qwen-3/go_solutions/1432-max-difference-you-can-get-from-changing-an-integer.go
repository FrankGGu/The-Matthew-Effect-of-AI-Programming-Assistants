package main

func maxDiff(num int) int {
    s := strconv.Itoa(num)
    minNum := num
    maxNum := num
    for i := 0; i < len(s); i++ {
        if s[i] != '9' {
            maxStr := strings.Replace(s, string(s[i]), "9", 1)
            maxNum = int(parse(maxStr))
            break
        }
    }
    for i := 0; i < len(s); i++ {
        if s[i] != '1' && s[i] != '0' {
            minStr := strings.Replace(s, string(s[i]), "0", 1)
            minNum = int(parse(minStr))
            break
        }
    }
    return maxNum - minNum
}

func parse(s string) int {
    num, _ := strconv.Atoi(s)
    return num
}