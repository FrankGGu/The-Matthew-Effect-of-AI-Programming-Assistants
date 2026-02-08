import (
	"strconv"
)

func addOperators(num string, target int) []string {
	res := []string{}
	var dfs func(idx int, cur int, prev int, expr string)
	dfs = func(idx int, cur int, prev int, expr string) {
		if idx == len(num) {
			if cur == target {
				res = append(res, expr)
			}
			return
		}

		for i := idx; i < len(num); i++ {
			if i > idx && num[idx] == '0' {
				break
			}
			s := num[idx : i+1]
			val, _ := strconv.Atoi(s)

			if idx == 0 {
				dfs(i+1, val, val, s)
			} else {
				dfs(i+1, cur+val, val, expr+"+"+s)
				dfs(i+1, cur-val, -val, expr+"-"+s)
				dfs(i+1, cur-prev+prev*val, prev*val, expr+"*"+s)
			}
		}
	}

	dfs(0, 0, 0, "")
	return res
}