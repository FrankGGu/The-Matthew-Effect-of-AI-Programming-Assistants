package main

func maxDiff(num int) int {
    s := strconv.Itoa(num)
    minNum := num
    maxNum := num
    for i := 0; i < len(s); i++ {
        if s[i] != '9' {
            temp := strings.Replace(s, string(s[i]), "9", 1)
            maxNum, _ = strconv.Atoi(temp)
            break
        }
    }
    for i := 0; i < len(s); i++ {
        if s[i] != '1' && s[i] != '0' {
            temp := strings.Replace(s, string(s[i]), "0", 1)
            minNum, _ = strconv.Atoi(temp)
            break
        }
    }
    return maxNum - minNum
}