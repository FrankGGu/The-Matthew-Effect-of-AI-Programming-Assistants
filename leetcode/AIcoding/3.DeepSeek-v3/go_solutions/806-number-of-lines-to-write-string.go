func numberOfLines(widths []int, s string) []int {
    lines, currentWidth := 1, 0
    for _, c := range s {
        width := widths[c - 'a']
        if currentWidth + width > 100 {
            lines++
            currentWidth = width
        } else {
            currentWidth += width
        }
    }
    return []int{lines, currentWidth}
}