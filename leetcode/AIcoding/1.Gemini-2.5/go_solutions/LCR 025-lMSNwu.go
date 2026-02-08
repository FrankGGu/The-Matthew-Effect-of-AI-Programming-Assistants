type Stack []int

func (s *Stack) Push(val int) {
	*s = append(*s, val)
}