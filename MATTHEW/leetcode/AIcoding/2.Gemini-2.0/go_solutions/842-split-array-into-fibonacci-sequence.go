func splitIntoFibonacci(s string) []int {
	n := len(s)
	var res []int

	var backtrack func(index int, seq []int) bool
	backtrack = func(index int, seq []int) bool {
		if index == n {
			return len(seq) >= 3
		}

		for i := index; i < n; i++ {
			if i > index && s[index] == '0' {
				break
			}
			numStr := s[index : i+1]
			num := 0
			for j := 0; j < len(numStr); j++ {
				digit := int(numStr[j] - '0')
				if num > (1<<31-1)/10 || (num == (1<<31-1)/10 && digit > 7) {
					num = -1
					break
				}
				num = num*10 + digit
			}
			if num == -1 {
				break
			}

			if len(seq) >= 2 {
				if num > seq[len(seq)-1]+seq[len(seq)-2] {
					break
				}
				if num < seq[len(seq)-1]+seq[len(seq)-2] {
					continue
				}
			}

			newSeq := append(seq, num)
			if backtrack(i+1, newSeq) {
				res = newSeq
				return true
			}
		}
		return false
	}

	if backtrack(0, []int{}) {
		return res
	}
	return []int{}
}