package main

func primePalindrome(n int) int {
	if n <= 2 {
		return 2
	}
	if n == 3 {
		return 3
	}
	if n == 5 {
		return 5
	}
	if n == 7 {
		return 7
	}
	if n == 11 {
		return 11
	}

	for i := 1; ; i++ {
		s := strconv.Itoa(i)
		pal := s + reverse(s)
		num, _ := strconv.Atoi(pal)
		if num >= n && isPrime(num) {
			return num
		}
		s = strconv.Itoa(i)
		pal = s + reverse(s)[1:]
		num, _ = strconv.Atoi(pal)
		if num >= n && isPrime(num) {
			return num
		}
	}
}

func reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func isPrime(x int) bool {
	if x < 2 {
		return false
	}
	if x == 2 {
		return true
	}
	if x%2 == 0 {
		return false
	}
	for i := 3; i*i <= x; i += 2 {
		if x%i == 0 {
			return false
		}
	}
	return true
}