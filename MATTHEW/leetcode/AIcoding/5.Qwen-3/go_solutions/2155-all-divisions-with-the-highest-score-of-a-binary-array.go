package main

func highScoreSegments(binaryArray []int) []int {
    n := len(binaryArray)
    maxScore := 0
    result := []int{}

    for i := 0; i <= n; i++ {
        leftZeros := 0
        rightOnes := 0

        for j := 0; j < i; j++ {
            if binaryArray[j] == 0 {
                leftZeros++
            }
        }

        for j := i; j < n; j++ {
            if binaryArray[j] == 1 {
                rightOnes++
            }
        }

        score := leftZeros + rightOnes

        if score > maxScore {
            maxScore = score
            result = []int{i}
        } else if score == maxScore {
            result = append(result, i)
        }
    }

    return result
}