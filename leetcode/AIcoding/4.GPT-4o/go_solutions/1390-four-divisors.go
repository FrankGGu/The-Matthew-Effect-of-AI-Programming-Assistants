func sumFourDivisors(nums []int) int {
    sum := 0
    for _, num := range nums {
        divisors := []int{}
        for i := 1; i*i <= num; i++ {
            if num%i == 0 {
                divisors = append(divisors, i)
                if i != num/i {
                    divisors = append(divisors, num/i)
                }
            }
            if len(divisors) > 4 {
                break
            }
        }
        if len(divisors) == 4 {
            sum += divisors[0] + divisors[1] + divisors[2] + divisors[3]
        }
    }
    return sum
}