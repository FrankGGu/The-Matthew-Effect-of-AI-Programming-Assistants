func compress(chars []byte) int {
	n := len(chars)
	if n == 0 {
		return 0
	}

	write := 0
	count := 1
	for i := 1; i <= n; i++ {
		if i < n && chars[i] == chars[i-1] {
			count++
		} else {
			chars[write] = chars[i-1]
			write++
			if count > 1 {
				countStr := []byte{}
				temp := count
				for temp > 0 {
					countStr = append([]byte{byte('0' + temp%10)}, countStr...)
					temp /= 10
				}
				for _, c := range countStr {
					chars[write] = c
					write++
				}
			}
			count = 1
		}
	}

	return write
}