type TextEditor struct {
	left  []rune
	right []rune
}

func Constructor() TextEditor {
	return TextEditor{
		left:  make([]rune, 0),
		right: make([]rune, 0),
	}
}

func (this *TextEditor) AddText(text string) {
	this.left = append(this.left, []rune(text)...)
}

func (this *TextEditor) DeleteText(k int) int {
	deletedCount := 0
	if k >= len(this.left) {
		deletedCount = len(this.left)
		this.left = make([]rune, 0)
	} else {
		deletedCount = k
		this.left = this.left[:len(this.left)-k]
	}
	return deletedCount
}

func (this *TextEditor) CursorLeft(k int) string {
	for i := 0; i < k && len(this.left) > 0; i++ {
		charToMove := this.left[len(this.left)-1]
		this.left = this.left[:len(this.left)-1]
		this.right = append(this.right, charToMove)
	}

	start := 0
	if len(this.left) > 10 {
		start = len(this.left) - 10
	}
	return string(this.left[start:])
}

func (this *TextEditor) CursorRight(k int) string {
	for i := 0; i < k && len(this.right) > 0; i++ {
		charToMove := this.right[len(this.right)-1]
		this.right = this.right[:len(this.right)-1]
		this.left = append(this.left, charToMove)
	}

	start := 0
	if len(this.left) > 10 {
		start = len(this.left) - 10
	}
	return string(this.left[start:])
}