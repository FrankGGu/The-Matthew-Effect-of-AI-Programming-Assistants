func prefixesDivBy5(A []int) []bool {
	result := make([]bool, len(A))
	num := 0
	for i, bit := range A {
		num = (num*2 + bit) % 5
		result[i] = num == 0
	}
	return result
}