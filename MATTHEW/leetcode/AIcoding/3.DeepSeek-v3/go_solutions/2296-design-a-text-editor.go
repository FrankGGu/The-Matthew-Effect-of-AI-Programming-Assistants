type TextEditor struct {
    left  []byte
    right []byte
}

func Constructor() TextEditor {
    return TextEditor{
        left:  make([]byte, 0),
        right: make([]byte, 0),
    }
}

func (this *TextEditor) AddText(text string) {
    this.left = append(this.left, []byte(text)...)
}

func (this *TextEditor) DeleteText(k int) int {
    cnt := 0
    if len(this.left) >= k {
        cnt = k
    } else {
        cnt = len(this.left)
    }
    this.left = this.left[:len(this.left)-cnt]
    return cnt
}

func (this *TextEditor) CursorLeft(k int) string {
    move := k
    if len(this.left) < k {
        move = len(this.left)
    }
    for i := 0; i < move; i++ {
        this.right = append(this.right, this.left[len(this.left)-1])
        this.left = this.left[:len(this.left)-1]
    }
    return this.String()
}

func (this *TextEditor) CursorRight(k int) string {
    move := k
    if len(this.right) < k {
        move = len(this.right)
    }
    for i := 0; i < move; i++ {
        this.left = append(this.left, this.right[len(this.right)-1])
        this.right = this.right[:len(this.right)-1]
    }
    return this.String()
}

func (this *TextEditor) String() string {
    start := 0
    if len(this.left) > 10 {
        start = len(this.left) - 10
    }
    return string(this.left[start:])
}