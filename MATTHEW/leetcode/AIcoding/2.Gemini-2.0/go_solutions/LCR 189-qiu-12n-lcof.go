type Calculator struct {
    current int
}

func Constructor() Calculator {
    return Calculator{current: 0}
}

func (this *Calculator) Add(num int) {
    this.current += num
}

func (this *Calculator) Subtract(num int) {
    this.current -= num
}

func (this *Calculator) Multiply(num int) {
    this.current *= num
}

func (this *Calculator) Divide(num int) {
    if num == 0 {
        return
    }
    this.current /= num
}

func (this *Calculator) GetResult() int {
    return this.current
}