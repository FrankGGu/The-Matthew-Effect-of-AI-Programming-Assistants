func minMaxDifference(num int) int {
    strNum := strconv.Itoa(num)
    minNum := strNum
    maxNum := strNum

    for i := 0; i < len(strNum); i++ {
        if strNum[i] != '9' {
            maxNum = strings.ReplaceAll(maxNum, string(strNum[i]), "9")
            break
        }
    }

    for i := 0; i < len(strNum); i++ {
        if strNum[i] != '0' && minNum[0] == strNum[0] {
            minNum = strings.ReplaceAll(minNum, string(strNum[i]), "0")
            break
        } else if strNum[i] != strNum[0] {
            minNum = strings.ReplaceAll(minNum, string(strNum[i]), string(strNum[0]))
            break
        }
    }

    maxVal, _ := strconv.Atoi(maxNum)
    minVal, _ := strconv.Atoi(minNum)

    return maxVal - minVal
}