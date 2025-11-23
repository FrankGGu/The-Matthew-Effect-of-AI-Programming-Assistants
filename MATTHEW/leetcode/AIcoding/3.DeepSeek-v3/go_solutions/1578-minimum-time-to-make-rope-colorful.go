func minCost(colors string, neededTime []int) int {
    totalTime := 0
    i := 0
    n := len(colors)

    for i < n {
        currentColor := colors[i]
        maxTime := neededTime[i]
        sumTime := neededTime[i]
        j := i + 1

        for j < n && colors[j] == currentColor {
            if neededTime[j] > maxTime {
                maxTime = neededTime[j]
            }
            sumTime += neededTime[j]
            j++
        }

        if j - i > 1 {
            totalTime += sumTime - maxTime
        }

        i = j
    }

    return totalTime
}