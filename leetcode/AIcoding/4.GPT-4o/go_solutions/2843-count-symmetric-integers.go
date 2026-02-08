func countSymmetricIntegers(low int, high int) int {
    count := 0
    for i := low; i <= high; i++ {
        if isSymmetric(i) {
            count++
        }
    }
    return count
}

func isSymmetric(num int) bool {
    sum1, sum2 := 0, 0
    strNum := fmt.Sprintf("%d", num)
    length := len(strNum)
    for i := 0; i < length/2; i++ {
        sum1 += int(strNum[i] - '0')
        sum2 += int(strNum[length-i-1] - '0')
    }
    if length%2 == 1 {
        sum1 += int(strNum[length/2] - '0')
    }
    return sum1 == sum2
}