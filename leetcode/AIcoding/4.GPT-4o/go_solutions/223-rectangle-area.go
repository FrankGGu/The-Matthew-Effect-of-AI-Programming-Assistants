func computeArea(A int, B int, C int, D int, E int, F int, G int, H int) int {
    area1 := (C - A) * (D - B)
    area2 := (G - E) * (H - F)

    overlapWidth := max(0, min(C, G) - max(A, E))
    overlapHeight := max(0, min(D, H) - max(B, F))
    overlapArea := overlapWidth * overlapHeight

    return area1 + area2 - overlapArea
}

func min(x, y int) int {
    if x < y {
        return x
    }
    return y
}

func max(x, y int) int {
    if x > y {
        return x
    }
    return y
}