type OrderedStream struct {
    ptr  int
    stream []string
}

func Constructor(n int) OrderedStream {
    return OrderedStream{
        ptr:    0,
        stream: make([]string, n),
    }
}

func (this *OrderedStream) Insert(idKey int, value string) []string {
    this.stream[idKey-1] = value
    result := []string{}
    for this.ptr < len(this.stream) && this.stream[this.ptr] != "" {
        result = append(result, this.stream[this.ptr])
        this.ptr++
    }
    return result
}