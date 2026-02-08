func numberOfLines(widths []int, s string) []int {
    lines := 1
    currentLineWidth := 0

    for _, char := range s {
        charWidth := widths[char - 'a']

        if currentLineWidth + charWidth > 100 {
            lines++
            currentLineWidth = charWidth
        } else {
            currentLineWidth += charWidth
        }
    }

    return []int{lines, currentLineWidth}
}