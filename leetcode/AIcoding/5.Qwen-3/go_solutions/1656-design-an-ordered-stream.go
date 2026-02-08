package main

type OrderedStream struct {
	data []string
	ptr  int
}

func Constructor(n int, values []string) OrderedStream {
	return OrderedStream{
		data: values,
		ptr:  0,
	}
}

func (this *OrderedStream) GetResult() []string {
	result := make([]string, 0)
	for this.ptr < len(this.data) && this.data[this.ptr] != "" {
		result = append(result, this.data[this.ptr])
		this.ptr++
	}
	return result
}