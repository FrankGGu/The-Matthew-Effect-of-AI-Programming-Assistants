type Machine struct {
    sum int
}

func Constructor() Machine {
    return Machine{sum: 0}
}

func (this *Machine) Add(num int) int {
    this.sum += num
    return this.sum
}

func (this *Machine) Reset() {
    this.sum = 0
}

/**
 * Your Machine object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Add(num);
 * obj.Reset();
 */