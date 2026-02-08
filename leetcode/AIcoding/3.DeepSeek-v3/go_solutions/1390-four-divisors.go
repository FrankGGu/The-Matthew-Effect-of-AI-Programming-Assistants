func sumFourDivisors(nums []int) int {
    total := 0
    for _, num := range nums {
        divisors := make([]int, 0)
        for i := 1; i*i <= num; i++ {
            if num%i == 0 {
                if i*i == num {
                    divisors = append(divisors, i)
                } else {
                    divisors = append(divisors, i, num/i)
                }
            }
            if len(divisors) > 4 {
                break
            }
        }
        if len(divisors) == 4 {
            sum := 0
            for _, d := range divisors {
                sum += d
            }
            total += sum
        }
    }
    return total
}