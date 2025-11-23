type OrderedStream struct {
    ptr    int
    values []string
}

func Constructor(n int) OrderedStream {
    return OrderedStream{
        ptr:    1,
        values: make([]string, n+1),
    }
}

func (this *OrderedStream) Insert(idKey int, value string) []string {
    this.values[idKey] = value
    res := []string{}
    if idKey == this.ptr {
        for this.ptr < len(this.values) && this.values[this.ptr] != "" {
            res = append(res, this.values[this.ptr])
            this.ptr++
        }
    }
    return res
}