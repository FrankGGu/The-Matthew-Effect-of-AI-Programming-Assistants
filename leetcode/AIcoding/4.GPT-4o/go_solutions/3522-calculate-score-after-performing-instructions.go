func calPoints(instructions []string) int {
    scoreStack := []int{}
    for _, instruction := range instructions {
        switch instruction {
        case "+":
            n := len(scoreStack)
            scoreStack = append(scoreStack, scoreStack[n-1]+scoreStack[n-2])
        case "D":
            scoreStack = append(scoreStack, 2*scoreStack[len(scoreStack)-1])
        case "C":
            scoreStack = scoreStack[:len(scoreStack)-1]
        default:
            var points int
            fmt.Sscanf(instruction, "%d", &points)
            scoreStack = append(scoreStack, points)
        }
    }

    totalScore := 0
    for _, score := range scoreStack {
        totalScore += score
    }

    return totalScore
}