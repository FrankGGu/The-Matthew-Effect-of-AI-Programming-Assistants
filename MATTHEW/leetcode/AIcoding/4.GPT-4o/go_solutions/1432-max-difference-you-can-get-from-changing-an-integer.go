func maximumDifference(num int) int {
    strNum := strconv.Itoa(num)
    minNum, maxNum := strNum, strNum

    for i := 0; i < len(strNum); i++ {
        if strNum[i] != '9' {
            maxNum = strNum[:i] + "9" + strNum[i+1:]
            break
        }
    }

    for i := 0; i < len(strNum); i++ {
        if strNum[i] != '0' {
            minNum = strNum[:i] + "0" + strNum[i+1:]
            break
        }
    }

    maxVal, _ := strconv.Atoi(maxNum)
    minVal, _ := strconv.Atoi(minNum)

    return maxVal - minVal
}