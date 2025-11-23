package main

func checkPerfectNumber(num int) int {
    if num <= 1 {
        return 0
    }
    sum := 1
    sqrtNum := int(math.Sqrt(float64(num)))
    for i := 2; i <= sqrtNum; i++ {
        if num%i == 0 {
            sum += i
            counterpart := num / i
            if counterpart != i {
                sum += counterpart
            }
        }
    }
    return sum
}