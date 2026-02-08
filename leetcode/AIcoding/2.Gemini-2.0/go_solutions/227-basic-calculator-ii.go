func calculate(s string) int {
	nums := []int{}
	ops := []byte{}
	num := 0
	for i := 0; i < len(s); i++ {
		if s[i] >= '0' && s[i] <= '9' {
			num = num*10 + int(s[i]-'0')
		} else if s[i] == '+' || s[i] == '-' || s[i] == '*' || s[i] == '/' {
			nums = append(nums, num)
			num = 0
			ops = append(ops, s[i])
		}
	}
	nums = append(nums, num)

	newNums := []int{}
	newOps := []byte{}

	for i := 0; i < len(ops); i++ {
		if ops[i] == '*' || ops[i] == '/' {
			num1 := nums[0]
			num2 := nums[1]
			nums = nums[2:]
			var res int
			if ops[i] == '*' {
				res = num1 * num2
			} else {
				res = num1 / num2
			}
			nums = append([]int{res}, nums...)
		} else {
			newNums = append(newNums, nums[0])
			nums = nums[1:]
			newOps = append(newOps, ops[i])
		}
	}
	newNums = append(newNums, nums[0])

	res := newNums[0]
	for i := 0; i < len(newOps); i++ {
		if newOps[i] == '+' {
			res += newNums[i+1]
		} else {
			res -= newNums[i+1]
		}
	}

	return res
}