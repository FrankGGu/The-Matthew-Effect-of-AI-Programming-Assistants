func differenceOfSums(arr []int) int {
    divisibleSum := 0
    nonDivisibleSum := 0
    for _, num := range arr {
        if num%2 == 0 {
            divisibleSum += num
        } else {
            nonDivisibleSum += num
        }
    }
    return divisibleSum - nonDivisibleSum
}