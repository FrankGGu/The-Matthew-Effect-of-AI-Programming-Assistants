type MinStack struct {
	dataStack []int
	minStack  []int
}

func Constructor() MinStack {
	return MinStack{
		dataStack: []int{},
		minStack:  []int{},
	}
}

func (this *MinStack) Push(val int) {
	this.dataStack = append(this.dataStack, val)
	if len(this.minStack) == 0 || val <= this.minStack[len(this.minStack)-1] {
		this.minStack = append(this.minStack, val)
	}
}

func (this *MinStack) Pop() {
	poppedVal := this.dataStack[len(this.dataStack)-1]
	this.dataStack = this.dataStack[:len(this.dataStack)-1]

	if poppedVal == this.minStack[len(this.minStack)-1] {
		this.minStack = this.minStack[:len(this.minStack)-1]
	}
}

func (this *MinStack) Top() int {
	return this.dataStack[len(this.dataStack)-1]
}

func (this *MinStack) GetMin() int {
	return this.minStack[len(this.minStack)-1]
}