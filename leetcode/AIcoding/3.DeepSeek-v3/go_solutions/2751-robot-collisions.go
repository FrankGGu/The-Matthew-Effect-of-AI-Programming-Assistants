func survivedRobotsHealths(positions []int, healths []int, directions string) []int {
    n := len(positions)
    robots := make([]int, n)
    for i := range robots {
        robots[i] = i
    }
    sort.Slice(robots, func(i, j int) bool {
        return positions[robots[i]] < positions[robots[j]]
    })

    stack := []int{}
    for _, idx := range robots {
        if directions[idx] == 'R' {
            stack = append(stack, idx)
            continue
        }
        for len(stack) > 0 {
            top := stack[len(stack)-1]
            if healths[top] > healths[idx] {
                healths[top]--
                healths[idx] = 0
                break
            } else if healths[top] < healths[idx] {
                healths[idx]--
                healths[top] = 0
                stack = stack[:len(stack)-1]
            } else {
                healths[top] = 0
                healths[idx] = 0
                stack = stack[:len(stack)-1]
                break
            }
        }
    }

    res := []int{}
    for _, h := range healths {
        if h > 0 {
            res = append(res, h)
        }
    }
    return res
}