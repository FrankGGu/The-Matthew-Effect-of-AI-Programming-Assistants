import (
	"sort"
	"strconv"
)

func splitNum(num int) int {
	s := strconv.Itoa(num)
	arr := []rune(s)
	sort.Slice(arr, func(i, j int) bool {
		return arr[i] < arr[j]
	})

	num1 := ""
	num2 := ""
	for i := 0; i < len(arr); i++ {
		if i%2 == 0 {
			num1 += string(arr[i])
		} else {
			num2 += string(arr[i])
		}
	}

	n1, _ := strconv.Atoi(num1)
	n2, _ := strconv.Atoi(num2)

	return n1 + n2
}