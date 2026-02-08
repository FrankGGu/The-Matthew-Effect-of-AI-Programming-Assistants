type RangeModule struct {
	ranges [][]int
}

func Constructor() RangeModule {
	return RangeModule{
		ranges: [][]int{},
	}
}

func (this *RangeModule) AddRange(left int, right int) {
	// Find the first interval