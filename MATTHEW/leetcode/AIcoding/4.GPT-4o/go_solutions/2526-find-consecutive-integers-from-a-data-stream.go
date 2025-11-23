type DataStream struct {
    value   int
    k       int
    count   int
}

func Constructor(value int, k int) DataStream {
    return DataStream{value: value, k: k, count: 0}
}

func (this *DataStream) Consecutive(num int) bool {
    if num == this.value {
        this.count++
    } else {
        this.count = 1
        this.value = num
    }
    return this.count >= this.k
}