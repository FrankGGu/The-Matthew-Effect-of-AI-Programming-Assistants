package main

func survivedRobotsHealths(positions [][]int, healths []int) []int {
    n := len(positions)
    idx := make([]int, n)
    for i := range idx {
        idx[i] = i
    }
    sort.Slice(idx, func(i, j int) bool {
        return positions[idx[i]][0] < positions[idx[j]][0]
    })
    type robot struct {
        pos, health, index int
    }
    robots := make([]robot, n)
    for i := range idx {
        robots[i] = robot{positions[idx[i]][0], healths[idx[i]], idx[i]}
    }
    stack := []robot{}
    for _, r := range robots {
        for len(stack) > 0 && stack[len(stack)-1].health < r.health {
            if stack[len(stack)-1].health == r.health {
                stack = stack[:len(stack)-1]
                break
            }
            r.health -= stack[len(stack)-1].health
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            stack = append(stack, r)
        } else if stack[len(stack)-1].health > r.health {
            stack[len(stack)-1].health -= r.health
        }
    }
    result := make([]int, len(stack))
    for i, r := range stack {
        result[i] = r.health
    }
    sort.Ints(result)
    return result
}