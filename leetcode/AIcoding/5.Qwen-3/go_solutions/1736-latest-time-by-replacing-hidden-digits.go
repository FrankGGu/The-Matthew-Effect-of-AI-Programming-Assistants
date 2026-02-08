package main

func maximumTime(s string) string {
	runes := []rune(s)
	if runes[0] == '?' {
		if runes[1] == '?' {
			runes[0] = '2'
			runes[1] = '3'
		} else if runes[1] <= '3' {
			runes[0] = '2'
		} else {
			runes[0] = '1'
		}
	}
	if runes[1] == '?' {
		if runes[0] == '2' {
			runes[1] = '3'
		} else {
			runes[1] = '9'
		}
	}
	if runes[3] == '?' {
		runes[3] = '5'
	}
	if runes[4] == '?' {
		runes[4] = '9'
	}
	return string(runes)
}