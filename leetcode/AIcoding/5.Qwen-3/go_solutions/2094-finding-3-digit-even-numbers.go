package main

func findEvenNumbers(digits []int) []int {
    var result []int
    for i := 0; i < len(digits); i++ {
        if digits[i] == 0 {
            continue
        }
        for j := 0; j < len(digits); j++ {
            if j == i {
                continue
            }
            for k := 0; k < len(digits); k++ {
                if k == i || k == j {
                    continue
                }
                num := digits[i]*100 + digits[j]*10 + digits[k]
                if num%2 == 0 {
                    result = append(result, num)
                }
            }
        }
    }
    return result
}