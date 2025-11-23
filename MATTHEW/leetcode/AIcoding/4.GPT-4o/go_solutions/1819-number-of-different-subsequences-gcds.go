func countDifferentSubseqGCDs(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    gcdCount := make([]bool, maxNum+1)
    for _, num := range nums {
        gcdCount[num] = true
    }

    result := 0
    for g := 1; g <= maxNum; g++ {
        currentGCD := 0
        for multiple := g; multiple <= maxNum; multiple += g {
            if gcdCount[multiple] {
                currentGCD = gcd(currentGCD, multiple)
            }
        }
        if currentGCD == g {
            result++
        }
    }

    return result
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}