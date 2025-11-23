type TextEditor struct {
    text    string
    cursor  int
}

func Constructor() TextEditor {
    return TextEditor{text: "", cursor: 0}
}

func (this *TextEditor) AddText(text string) {
    this.text = this.text[:this.cursor] + text + this.text[this.cursor:]
    this.cursor += len(text)
}

func (this *TextEditor) DeleteText(k int) int {
    deleteCount := min(k, this.cursor)
    this.text = this.text[:this.cursor-deleteCount] + this.text[this.cursor:]
    this.cursor -= deleteCount
    return deleteCount
}

func (this *TextEditor) CursorLeft(k int) string {
    this.cursor = max(0, this.cursor-k)
    return this.getLast10Chars()
}

func (this *TextEditor) CursorRight(k int) string {
    this.cursor = min(len(this.text), this.cursor+k)
    return this.getLast10Chars()
}

func (this *TextEditor) getLast10Chars() string {
    start := max(0, this.cursor-10)
    return this.text[start:this.cursor]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}