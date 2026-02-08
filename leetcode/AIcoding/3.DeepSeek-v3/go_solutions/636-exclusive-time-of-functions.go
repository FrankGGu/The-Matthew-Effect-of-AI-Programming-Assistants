func exclusiveTime(n int, logs []string) []int {
    res := make([]int, n)
    stack := []int{}
    prevTime := 0

    for _, log := range logs {
        parts := strings.Split(log, ":")
        id, _ := strconv.Atoi(parts[0])
        typ := parts[1]
        time, _ := strconv.Atoi(parts[2])

        if typ == "start" {
            if len(stack) > 0 {
                res[stack[len(stack)-1]] += time - prevTime
            }
            stack = append(stack, id)
            prevTime = time
        } else {
            res[stack[len(stack)-1]] += time - prevTime + 1
            stack = stack[:len(stack)-1]
            prevTime = time + 1
        }
    }

    return res
}