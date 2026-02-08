package main

func findEvenNumbers(digits []int) int {
    seen := make(map[string]bool)
    var result int

    for i := 0; i < len(digits); i++ {
        for j := 0; j < len(digits); j++ {
            if j == i {
                continue
            }
            for k := 0; k < len(digits); k++ {
                if k == i || k == j {
                    continue
                }
                if digits[k]%2 == 0 {
                    num := digits[i]*100 + digits[j]*10 + digits[k]
                    key := fmt.Sprintf("%d%d%d", digits[i], digits[j], digits[k])
                    if !seen[key] {
                        seen[key] = true
                        result++
                    }
                }
            }
        }
    }

    return result
}