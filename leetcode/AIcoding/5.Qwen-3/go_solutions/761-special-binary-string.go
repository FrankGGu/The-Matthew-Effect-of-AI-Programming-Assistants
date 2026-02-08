package main

func specialBinaryString(s string) string {
	var dfs func(string) string
	dfs = func(s string) string {
		res := []byte{}
		count := 0
		start := 0
		for i, c := range s {
			if c == '0' {
				count--
			} else {
				count++
			}
			if count == 0 {
				res = append(res, []byte{0}...)
				res = append(res, dfs(s[start+1:i])...)
				start = i + 1
			}
		}
		for i := 0; i < len(res); i += 2 {
			if i+1 < len(res) && res[i] == '0' && res[i+1] == '0' {
				res[i], res[i+1] = res[i+1], res[i]
			}
		}
		return string(res)
	}
	return dfs(s)
}