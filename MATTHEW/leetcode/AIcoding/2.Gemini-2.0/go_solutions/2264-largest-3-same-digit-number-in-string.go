import "strconv"

func largestGoodInteger(num string) string {
	ans := ""
	for i := 0; i < len(num)-2; i++ {
		if num[i] == num[i+1] && num[i+1] == num[i+2] {
			s := string(num[i]) + string(num[i+1]) + string(num[i+2])
			if ans == "" || s > ans {
				ans = s
			}
		}
	}
	return ans
}