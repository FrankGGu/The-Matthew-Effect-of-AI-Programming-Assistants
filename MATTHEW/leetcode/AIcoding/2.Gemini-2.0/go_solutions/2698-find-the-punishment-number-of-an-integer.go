func punishmentNumber(n int) int {
	res := 0
	for i := 1; i <= n; i++ {
		if isPunishmentNumber(i) {
			res += i * i
		}
	}
	return res
}

func isPunishmentNumber(n int) bool {
	s := string(strconvItoa(n * n))
	return canPartition(s, 0, n)
}

func canPartition(s string, start int, target int) bool {
	if start == len(s) {
		return target == 0
	}
	sum := 0
	for i := start; i < len(s); i++ {
		sum = sum*10 + int(s[i]-'0')
		if sum > target {
			break
		}
		if canPartition(s, i+1, target-sum) {
			return true
		}
	}
	return false
}

func strconvItoa(n int) string {
	buf := [35]byte{}
	pos := 34
	for {
		buf[pos], n = '0'+byte(n%10), n/10
		pos--
		if n == 0 {
			break
		}
	}
	return string(buf[pos+1:])
}