func generateEvenNumbers() []int {
    uniqueNumbers := make(map[int]bool)
    for i := 100; i < 1000; i++ {
        if i%2 == 0 {
            digits := []int{(i / 100) % 10, (i / 10) % 10, i % 10}
            if digits[0] != digits[1] && digits[0] != digits[2] && digits[1] != digits[2] {
                uniqueNumbers[i] = true
            }
        }
    }
    result := []int{}
    for num := range uniqueNumbers {
        result = append(result, num)
    }
    return result
}

func countUniqueEvenNumbers() int {
    uniqueNumbers := generateEvenNumbers()
    return len(uniqueNumbers)
}