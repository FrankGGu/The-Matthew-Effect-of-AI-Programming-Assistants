import (
	"fmt"
	"sort"
	"strconv"
)

func largestTimeFromDigits(A []int) string {
	sort.Ints(A)
	ans := ""
	var permute func(arr []int, l, r int)
	permute = func(arr []int, l, r int) {
		if l == r {
			h := arr[0]*10 + arr[1]
			m := arr[2]*10 + arr[3]
			if h < 24 && m < 60 {
				time := fmt.Sprintf("%02d:%02d", h, m)
				if time > ans {
					ans = time
				}
			}
			return
		}
		for i := l; i <= r; i++ {
			arr[l], arr[i] = arr[i], arr[l]
			permute(arr, l+1, r)
			arr[l], arr[i] = arr[i], arr[l]
		}
	}
	permute(A, 0, 3)
	return ans
}