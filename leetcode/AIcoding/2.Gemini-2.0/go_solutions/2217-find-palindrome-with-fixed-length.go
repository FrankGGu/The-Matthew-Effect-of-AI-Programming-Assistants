func kthPalindrome(queries []int, intLength int) []int64 {
	halfLength := (intLength + 1) / 2
	start := pow10(halfLength - 1)
	end := pow10(halfLength) - 1

	result := make([]int64, len(queries))
	for i, q := range queries {
		num := start + q - 1
		if num > end {
			result[i] = -1
		} else {
			half := toString(num)
			palindrome := half
			if intLength%2 == 0 {
				palindrome += reverseString(half)
			} else {
				palindrome += reverseString(half[:len(half)-1])
			}
			result[i] = toInt64(palindrome)
		}
	}
	return result
}

func pow10(n int) int {
	res := 1
	for i := 0; i < n; i++ {
		res *= 10
	}
	return res
}

func toString(n int) string {
	s := ""
	for n > 0 {
		s = string(rune('0'+n%10)) + s
		n /= 10
	}
	return s
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func toInt64(s string) int64 {
	res := int64(0)
	for _, r := range s {
		res = res*10 + int64(r-'0')
	}
	return res
}

func main() {}