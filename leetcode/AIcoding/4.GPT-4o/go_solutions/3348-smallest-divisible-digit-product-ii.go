func smallestDivisibleDigitsProduct(n int) int {
    if n == 0 {
        return 10
    }
    if n == 1 {
        return 1
    }

    digits := []int{}
    for i := 9; i >= 2; i-- {
        for n%i == 0 {
            digits = append([]int{i}, digits...)
            n /= i
        }
    }

    if n > 1 {
        return -1
    }

    result := 0
    for _, d := range digits {
        result = result*10 + d
    }
    return result
}