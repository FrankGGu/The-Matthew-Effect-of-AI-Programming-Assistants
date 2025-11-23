func sequentialDigits(low int, high int) []int {
    result := []int{}
    for length := 1; length <= 9; length++ {
        for start := 1; start <= 10 - length; start++ {
            num := 0
            for i := 0; i < length; i++ {
                num = num * 10 + (start + i)
            }
            if num >= low && num <= high {
                result = append(result, num)
            }
        }
    }
    return result
}