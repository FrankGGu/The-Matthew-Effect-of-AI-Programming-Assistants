func findTheArrayConcVal(nums []int) int64 {
	n := len(nums)
	i := 0
	j := n - 1
	var sum int64
	for i < j {
		num1 := nums[i]
		num2 := nums[j]
		str := string(itoa(num1)) + string(itoa(num2))
		val, _ := atoi(str)
		sum += int64(val)
		i++
		j--
	}
	if i == j {
		sum += int64(nums[i])
	}
	return sum
}

func itoa(n int) []byte {
	if n == 0 {
		return []byte{'0'}
	}
	sign := false
	if n < 0 {
		sign = true
		n = -n
	}
	var digits []byte
	for n > 0 {
		digit := n % 10
		digits = append([]byte{byte(digit + '0')}, digits...)
		n /= 10
	}
	if sign {
		digits = append([]byte{'-'}, digits...)
	}
	return digits
}

func atoi(s string) (int, error) {
    n := 0
    sign := 1
    i := 0
    if i < len(s) && s[i] == '-' {
        sign = -1
        i++
    } else if i < len(s) && s[i] == '+' {
        i++
    }
    for i < len(s) {
        digit := s[i] - '0'
        if digit < 0 || digit > 9 {
            break
        }
        n = n*10 + int(digit)
        i++
    }
    return n * sign, nil
}