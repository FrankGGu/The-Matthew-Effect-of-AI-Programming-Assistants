import "sort"

func maxSatisfaction(satisfaction []int) int {
    sort.Ints(satisfaction)
    n := len(satisfaction)
    maxSatisfaction := 0
    currentSum := 0

    for i := n - 1; i >= 0; i-- {
        currentSum += satisfaction[i]
        if currentSum + maxSatisfaction > maxSatisfaction {
            maxSatisfaction += currentSum
        } else {
            break
        }
    }

    return maxSatisfaction
}