import (
	"fmt"
	"strconv"
)

func splitMessage(message string, limit int) []string {
	n := len(message)
	l := 1
	r := n
	k := 0
	for l <= r {
		mid := (l + r) / 2
		count := 0
		partLen := 0
		digitLen := 0
		for i := 1; i <= mid; i++ {
			digitLen = len(strconv.Itoa(i))
			partLen = len("<" + strconv.Itoa(i) + "/" + strconv.Itoa(mid) + ">")
			if limit-partLen <= 0 {
				count = n + 1
				break
			}
			count += limit - partLen
		}
		if count >= n {
			k = mid
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	if k == 0 {
		return []string{}
	}

	res := make([]string, k)
	start := 0
	for i := 1; i <= k; i++ {
		partLen := len("<" + strconv.Itoa(i) + "/" + strconv.Itoa(k) + ">")
		length := limit - partLen
		res[i-1] = message[start:min(start+length, n)] + "<" + strconv.Itoa(i) + "/" + strconv.Itoa(k) + ">"
		start += length
	}

	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}