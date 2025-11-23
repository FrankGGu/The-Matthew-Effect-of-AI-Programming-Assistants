import (
	"strconv"
)

func maximumNumber(num string, change []int) string {
	n := len(num)
	res := []byte(num)
	start := -1
	end := -1

	for i := 0; i < n; i++ {
		digit, _ := strconv.Atoi(string(num[i]))
		if change[digit] > digit {
			start = i
			break
		}
	}

	if start == -1 {
		return num
	}

	for i := start; i < n; i++ {
		digit, _ := strconv.Atoi(string(num[i]))
		if change[digit] >= digit {
			res[i] = byte(change[digit] + '0')
			end = i
		} else {
			break
		}
	}

	return string(res)
}