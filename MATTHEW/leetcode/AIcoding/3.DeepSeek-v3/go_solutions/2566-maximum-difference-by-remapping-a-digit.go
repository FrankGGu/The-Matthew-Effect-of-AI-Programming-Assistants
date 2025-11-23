func minMaxDifference(num int) int {
    s := strconv.Itoa(num)
    maxNum, minNum := num, num

    for i := 0; i < 10; i++ {
        for j := 0; j < 10; j++ {
            newS := make([]byte, len(s))
            for k := 0; k < len(s); k++ {
                if s[k] == byte('0'+i) {
                    newS[k] = byte('0' + j)
                } else {
                    newS[k] = s[k]
                }
            }
            newNum, _ := strconv.Atoi(string(newS))
            if newNum > maxNum {
                maxNum = newNum
            }
            if newNum < minNum {
                minNum = newNum
            }
        }
    }

    return maxNum - minNum
}