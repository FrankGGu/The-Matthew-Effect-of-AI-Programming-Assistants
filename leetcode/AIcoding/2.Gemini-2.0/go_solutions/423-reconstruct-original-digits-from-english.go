func originalDigits(s string) string {
	count := make([]int, 26)
	for _, c := range s {
		count[c-'a']++
	}

	digits := make([]int, 10)
	digits[0] = count['z'-'a']
	digits[2] = count['w'-'a']
	digits[4] = count['u'-'a']
	digits[6] = count['x'-'a']
	digits[8] = count['g'-'a']

	digits[1] = count['o'-'a'] - digits[0] - digits[2] - digits[4]
	digits[3] = count['h'-'a'] - digits[8]
	digits[5] = count['f'-'a'] - digits[4]
	digits[7] = count['v'-'a'] - digits[5]
	digits[9] = count['i'-'a'] - digits[5] - digits[6] - digits[8]

	result := ""
	for i := 0; i < 10; i++ {
		for j := 0; j < digits[i]; j++ {
			result += string(rune('0' + i))
		}
	}
	return result
}