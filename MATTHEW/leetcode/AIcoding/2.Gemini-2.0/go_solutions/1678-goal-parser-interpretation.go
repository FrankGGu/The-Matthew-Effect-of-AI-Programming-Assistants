func interpret(command string) string {
	res := ""
	for i := 0; i < len(command); i++ {
		if command[i] == 'G' {
			res += "G"
		} else if command[i] == '(' {
			if command[i+1] == ')' {
				res += "o"
				i++
			} else {
				res += "al"
				i += 3
			}
		}
	}
	return res
}