func countDifferentSubsequenceGCDs(nums []int) int {
    maxNum := 0
    present := make(map[int]bool)
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
        present[num] = true
    }

    count := 0
    for x := 1; x <= maxNum; x++ {
        currentGcd := 0
        for multiple := x; multiple <= maxNum; multiple += x {
            if present[multiple] {
                if currentGcd == 0 {
                    currentGcd = multiple
                } else {
                    currentGcd = gcd(currentGcd, multiple)
                }
                if currentGcd == x {
                    count++
                    break
                }
            }
        }
    }
    return count
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}