type DinnerPlate struct {
    stacks [][]int
    capacity int
    nextIndex int
}

func Constructor(capacity int) DinnerPlate {
    return DinnerPlate{
        stacks:   make([][]int, 0),
        capacity: capacity,
        nextIndex: 0,
    }
}

func (d *DinnerPlate) Push(val int) {
    if d.nextIndex < len(d.stacks) {
        if len(d.stacks[d.nextIndex]) < d.capacity {
            d.stacks[d.nextIndex] = append(d.stacks[d.nextIndex], val)
        } else {
            d.nextIndex++
            d.stacks = append(d.stacks, []int{val})
        }
    } else {
        d.stacks = append(d.stacks, []int{val})
        d.nextIndex++
    }
}

func (d *DinnerPlate) Pop() int {
    if d.nextIndex == 0 {
        return -1
    }
    d.nextIndex--
    stack := &d.stacks[d.nextIndex]
    if len(*stack) == 0 {
        return -1
    }
    val := (*stack)[len(*stack)-1]
    *stack = (*stack)[:len(*stack)-1]
    if len(*stack) == 0 && d.nextIndex > 0 {
        d.nextIndex--
    }
    return val
}

func (d *DinnerPlate) PopAtStack(index int) int {
    if index < 0 || index >= d.nextIndex {
        return -1
    }
    stack := &d.stacks[index]
    if len(*stack) == 0 {
        return -1
    }
    val := (*stack)[len(*stack)-1]
    *stack = (*stack)[:len(*stack)-1]
    if len(*stack) == 0 && index == d.nextIndex-1 {
        d.nextIndex--
    }
    return val
}