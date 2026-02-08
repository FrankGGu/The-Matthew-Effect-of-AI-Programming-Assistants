func numberOfLines(widths []int, S string) []int {
    lines := 1
    currentWidth := 0

    for _, char := range S {
        charWidth := widths[char-'a']
        if currentWidth+charWidth > 100 {
            lines++
            currentWidth = charWidth
        } else {
            currentWidth += charWidth
        }
    }

    return []int{lines, currentWidth}
}