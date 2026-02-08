import (
    "sort"
    "strconv"
)

func splitNum(num int) int {
    s := strconv.Itoa(num)
    digits := []byte(s)
    sort.Slice(digits, func(i, j int) bool {
        return digits[i] < digits[j]
    })
    var num1, num2 int
    for i := 0; i < len(digits); i++ {
        digit := int(digits[i] - '0')
        if i%2 == 0 {
            num1 = num1*10 + digit
        } else {
            num2 = num2*10 + digit
        }
    }
    return num1 + num2
}