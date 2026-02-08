import "strconv"

func restoreIpAddresses(s string) []string {
	res := []string{}
	n := len(s)

	var backtrack func(int, int, []string)
	backtrack = func(index int, dots int, segments []string) {
		if dots == 4 {
			if index == n {
				ip := ""
				for i := 0; i < 4; i++ {
					ip += segments[i]
					if i < 3 {
						ip += "."
					}
				}
				res = append(res, ip)
			}
			return
		}

		for i := index; i < n && i < index+3; i++ {
			segment := s[index : i+1]
			num, _ := strconv.Atoi(segment)
			if (segment[0] == '0' && len(segment) > 1) || num > 255 {
				continue
			}
			backtrack(i+1, dots+1, append(segments, segment))
		}
	}

	backtrack(0, 0, []string{})
	return res
}