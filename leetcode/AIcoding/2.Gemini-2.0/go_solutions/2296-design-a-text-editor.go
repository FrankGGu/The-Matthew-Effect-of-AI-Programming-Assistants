type TextEditor struct {
	text []rune
	cursor int
}

func Constructor() TextEditor {
	return TextEditor{
		text:   []rune{},
		cursor: 0,
	}
}

func (this *TextEditor) AddText(text string) {
	runes := []rune(text)
	this.text = append(this.text[:this.cursor], append(runes, this.text[this.cursor:]...)...)
	this.cursor += len(runes)
}

func (this *TextEditor) DeleteText(k int) int {
	deleteCount := 0
	if k > 0 {
		deleteCount = min(k, this.cursor)
		this.text = this.text[:this.cursor-deleteCount]
		this.cursor -= deleteCount
	}
	return deleteCount
}

func (this *TextEditor) CursorLeft(k int) string {
	moveCount := min(k, this.cursor)
	this.cursor -= moveCount
	return this.getText()
}

func (this *TextEditor) CursorRight(k int) string {
	moveCount := min(k, len(this.text)-this.cursor)
	this.cursor += moveCount
	return this.getText()
}

func (this *TextEditor) getText() string {
	start := max(0, this.cursor-10)
	end := this.cursor
	return string(this.text[start:end])
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