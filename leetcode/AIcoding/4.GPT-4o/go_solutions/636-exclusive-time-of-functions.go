func exclusiveTime(n int, logs []string) []int {
    result := make([]int, n)
    stack := []int{}
    prevTime := 0

    for _, log := range logs {
        var id, time int
        var state string
        fmt.Sscanf(log, "%d:%s%d", &id, &state, &time)

        if len(stack) > 0 {
            result[stack[len(stack)-1]] += time - prevTime
        }
        prevTime = time

        if state == "start" {
            stack = append(stack, id)
            prevTime = time
        } else {
            result[stack[len(stack)-1]] += time - prevTime + 1
            stack = stack[:len(stack)-1]
            prevTime = time + 1
        }
    }

    return result
}