func maxTotalFruits(fruits [][]int, startPos int, k int) int {
    maxPos := 0
    for _, fruit := range fruits {
        if fruit[0] > maxPos {
            maxPos = fruit[0]
        }
    }
    if startPos > maxPos {
        maxPos = startPos
    }
    prefix := make([]int, maxPos+2)
    for _, fruit := range fruits {
        pos, amount := fruit[0], fruit[1]
        if pos <= maxPos {
            prefix[pos+1] += amount
        }
    }
    for i := 1; i <= maxPos+1; i++ {
        prefix[i] += prefix[i-1]
    }
    maxFruits := 0
    for leftSteps := 0; leftSteps <= k; leftSteps++ {
        rightSteps := k - 2*leftSteps
        if rightSteps >= 0 {
            left := startPos - leftSteps
            right := startPos + rightSteps
            if left < 0 {
                left = 0
            }
            if right > maxPos {
                right = maxPos
            }
            if left <= right {
                total := prefix[right+1] - prefix[left]
                if total > maxFruits {
                    maxFruits = total
                }
            }
        }
        rightSteps = k - 2*leftSteps
        rightSteps = leftSteps
        leftSteps = (k - rightSteps) / 2
        if leftSteps >= 0 && rightSteps >= 0 {
            left := startPos - leftSteps
            right := startPos + rightSteps
            if left < 0 {
                left = 0
            }
            if right > maxPos {
                right = maxPos
            }
            if left <= right {
                total := prefix[right+1] - prefix[left]
                if total > maxFruits {
                    maxFruits = total
                }
            }
        }
    }
    return maxFruits
}