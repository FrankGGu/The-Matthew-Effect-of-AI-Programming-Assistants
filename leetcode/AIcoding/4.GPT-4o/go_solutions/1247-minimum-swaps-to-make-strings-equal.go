func minimumSwap(s1 string, s2 string) int {
    if len(s1) != len(s2) {
        return -1
    }

    xy, yx := 0, 0
    for i := 0; i < len(s1); i++ {
        if s1[i] == 'x' && s2[i] == 'y' {
            xy++
        } else if s1[i] == 'y' && s2[i] == 'x' {
            yx++
        }
    }

    swaps := (xy + 1) / 2 + (yx + 1) / 2
    if (xy % 2) + (yx % 2) > 0 {
        return -1
    }
    return swaps
}