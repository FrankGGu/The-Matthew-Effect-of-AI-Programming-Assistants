package main

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
	for _, c := range text {
		this.left = append(this.left, c)
	}
}

func (this *TextEditor) DeleteText(k int) int {
	deleted := 0
	for deleted < k && len(this.left) > 0 {
		this.left = this.left[:len(this.left)-1]
		deleted++
	}
	return deleted
}

func (this *TextEditor) CursorLeft(k int) int {
	moved := 0
	for moved < k && len(this.left) > 0 {
		this.right = append(this.right, this.left[len(this.left)-1])
		this.left = this.left[:len(this.left)-1]
		moved++
	}
	return moved
}

func (this *TextEditor) CursorRight(k int) int {
	moved := 0
	for moved < k && len(this.right) > 0 {
		this.left = append(this.left, this.right[len(this.right)-1])
		this.right = this.right[:len(this.right)-1]
		moved++
	}
	return moved
}

func (this *TextEditor) Text() string {
	result := make([]rune, len(this.left)+len(this.right))
	copy(result, this.left)
	copy(result[len(this.left):], this.right)
	return string(result)
}