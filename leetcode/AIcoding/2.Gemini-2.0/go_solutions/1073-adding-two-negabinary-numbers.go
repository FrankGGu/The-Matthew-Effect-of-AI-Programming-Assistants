func addNegabinary(arr1 []int, arr2 []int) []int {
	i, j := len(arr1)-1, len(arr2)-1
	carry := 0
	result := []int{}
	for i >= 0 || j >= 0 || carry != 0 {
		x := 0
		if i >= 0 {
			x = arr1[i]
			i--
		}
		y := 0
		if j >= 0 {
			y = arr2[j]
			j--
		}
		sum := x + y + carry
		switch sum {
		case 0:
			result = append(result, 0)
			carry = 0
		case 1:
			result = append(result, 1)
			carry = 0
		case 2:
			result = append(result, 0)
			carry = -1
		case 3:
			result = append(result, 1)
			carry = -1
		case -1:
			result = append(result, 1)
			carry = 1
		}
	}
	for len(result) > 1 && result[len(result)-1] == 0 {
		result = result[:len(result)-1]
	}
	for k, l := 0, len(result)-1; k < l; k, l = k+1, l-1 {
		result[k], result[l] = result[l], result[k]
	}
	return result
}