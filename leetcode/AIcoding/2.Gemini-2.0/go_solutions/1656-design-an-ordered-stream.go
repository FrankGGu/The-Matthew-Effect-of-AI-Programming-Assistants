type OrderedStream struct {
	data []string
	ptr  int
}

func Constructor(n int) OrderedStream {
	return OrderedStream{
		data: make([]string, n+1),
		ptr:  1,
	}
}

func (this *OrderedStream) Insert(idKey int, value string) []string {
	this.data[idKey] = value
	result := []string{}
	for this.ptr < len(this.data) && this.data[this.ptr] != "" {
		result = append(result, this.data[this.ptr])
		this.ptr++
	}
	return result
}