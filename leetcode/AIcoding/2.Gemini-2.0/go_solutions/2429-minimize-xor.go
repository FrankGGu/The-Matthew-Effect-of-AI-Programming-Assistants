func minimizeXor(num1 int, num2 int) int {
	bits := 0
	for i := 0; i < 32; i++ {
		if (num2>>i)&1 == 1 {
			bits++
		}
	}

	result := 0
	temp := num1
	for i := 31; i >= 0 && bits > 0; i-- {
		if (temp>>i)&1 == 1 {
			result |= (1 << i)
			bits--
		}
	}

	for i := 0; i < 32 && bits > 0; i++ {
		if (temp>>i)&1 == 0 {
			result |= (1 << i)
			bits--
		}
	}

	return result
}