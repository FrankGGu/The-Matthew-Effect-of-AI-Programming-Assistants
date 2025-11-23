func predictPartyVictory(senate string) string {
    radiant, dire := 0, 0
    queue := make([]int, 0)

    for i, c := range senate {
        if c == 'R' {
            radiant++
            queue = append(queue, i)
        } else {
            dire++
            queue = append(queue, i)
        }
    }

    for radiant > 0 && dire > 0 {
        first := queue[0]
        queue = queue[1:]

        if senate[first] == 'R' {
            dire--
            queue = append(queue, first)
        } else {
            radiant--
            queue = append(queue, first)
        }
    }

    if radiant > 0 {
        return "Radiant"
    }
    return "Dire"
}