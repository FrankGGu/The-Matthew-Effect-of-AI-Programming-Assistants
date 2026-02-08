func maxHeightOfTriangle(red int, blue int) int {
    maxHeight := 0
    for color := 0; color < 2; color++ {
        r, b := red, blue
        if color == 1 {
            r, b = blue, red
        }
        for h := 1; ; h++ {
            required := h * (h + 1) / 2
            if h%2 == 1 {
                if r < required {
                    break
                }
                r -= required
            } else {
                if b < required {
                    break
                }
                b -= required
            }
            if h > maxHeight {
                maxHeight = h
            }
        }
    }
    return maxHeight
}