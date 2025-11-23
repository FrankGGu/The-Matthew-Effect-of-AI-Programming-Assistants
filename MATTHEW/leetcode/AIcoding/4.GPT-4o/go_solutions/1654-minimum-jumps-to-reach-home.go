func minimumJumps(forbidden []int, a int, b int, x int) int {
    forbiddenSet := make(map[int]struct{})
    for _, f := range forbidden {
        forbiddenSet[f] = struct{}{}
    }

    queue := []struct {
        pos  int
        jumps int
        canBack bool
    }{{0, 0, false}}
    visited := make(map[[3]int]bool)

    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]

        if curr.pos == x {
            return curr.jumps
        }

        if curr.pos > 6000 || curr.pos < 0 {
            continue
        }

        if _, ok := forbiddenSet[curr.pos]; ok {
            continue
        }

        key := [3]int{curr.pos, curr.jumps, boolToInt(curr.canBack)}
        if visited[key] {
            continue
        }
        visited[key] = true

        queue = append(queue, struct {
            pos  int
            jumps int
            canBack bool
        }{curr.pos + a, curr.jumps + 1, true})

        if curr.canBack {
            queue = append(queue, struct {
                pos  int
                jumps int
                canBack bool
            }{curr.pos - b, curr.jumps + 1, false})
        }
    }
    return -1
}

func boolToInt(b bool) int {
    if b {
        return 1
    }
    return 0
}