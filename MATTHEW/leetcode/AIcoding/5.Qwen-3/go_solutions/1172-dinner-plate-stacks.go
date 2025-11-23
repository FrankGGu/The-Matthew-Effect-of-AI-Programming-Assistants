package main

type DinnerPlates struct {
    stacks [][]int
    cap int
    leftMost int
}

func Constructor(cap int) DinnerPlates {
    return DinnerPlates{
        stacks: make([][]int, 0),
        cap: cap,
        leftMost: 0,
    }
}

func (this *DinnerPlates) Push(x int) {
    for this.leftMost < len(this.stacks) && len(this.stacks[this.leftMost]) == this.cap {
        this.leftMost++
    }
    if this.leftMost >= len(this.stacks) {
        this.stacks = append(this.stacks, []int{x})
    } else {
        this.stacks[this.leftMost] = append(this.stacks[this.leftMost], x)
    }
}

func (this *DinnerPlates) Pop() int {
    if len(this.stacks) == 0 {
        return -1
    }
    i := len(this.stacks) - 1
    for i >= 0 && len(this.stacks[i]) == 0 {
        i--
    }
    if i < 0 {
        return -1
    }
    val := this.stacks[i][len(this.stacks[i])-1]
    this.stacks[i] = this.stacks[i][:len(this.stacks[i])-1]
    return val
}

func (this *DinnerPlates) PopAtStack(index int) int {
    if index >= len(this.stacks) || len(this.stacks[index]) == 0 {
        return -1
    }
    val := this.stacks[index][len(this.stacks[index])-1]
    this.stacks[index] = this.stacks[index][:len(this.stacks[index])-1]
    return val
}