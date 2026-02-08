package main

func carFleet(target int, position []int, speed []int) int {
    type pair struct {
        pos int
        spd int
    }
    pairs := make([]pair, len(position))
    for i := range position {
        pairs[i] = pair{position[i], speed[i]}
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].pos > pairs[j].pos
    })

    stack := []float64{}
    for _, p := range pairs {
        time := float64(target-p.pos) / float64(p.spd)
        if len(stack) == 0 || time > stack[len(stack)-1] {
            stack = append(stack, time)
        }
    }

    return len(stack)
}