func maxDiff(num int) int {
    s := strconv.Itoa(num)
    maxNum, minNum := num, num

    for i := 0; i < 10; i++ {
        for j := 0; j < 10; j++ {
            newS := []byte(s)
            for k := range newS {
                if newS[k] == byte('0' + i) {
                    newS[k] = byte('0' + j)
                }
            }
            if newS[0] == '0' {
                continue
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