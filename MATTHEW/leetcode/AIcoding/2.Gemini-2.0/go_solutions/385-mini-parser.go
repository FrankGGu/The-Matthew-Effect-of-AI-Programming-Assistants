func deserialize(s string) *NestedInteger {
	if s[0] != '[' {
		val, _ := strconv.Atoi(s)
		res := NestedInteger{}
		res.SetInteger(val)
		return &res
	}
	res := NestedInteger{}
	stack := []*NestedInteger{&res}
	num := ""
	sign := 1
	for i := 1; i < len(s); i++ {
		switch s[i] {
		case '[':
			ni := NestedInteger{}
			stack[len(stack)-1].Add(ni)
			stack = append(stack, &ni)
		case ']':
			if len(num) > 0 {
				val, _ := strconv.Atoi(num)
				stack[len(stack)-1].SetInteger(sign * val)
				num = ""
				sign = 1
			}
			stack = stack[:len(stack)-1]
		case ',':
			if len(num) > 0 {
				val, _ := strconv.Atoi(num)
				stack[len(stack)-1].SetInteger(sign * val)
				num = ""
				sign = 1
			}
		case '-':
			sign = -1
		default:
			num += string(s[i])
		}
	}
	return &res
}