import (
	"sort"
	"strconv"
)

func largestInteger(num int) int {
	s := strconv.Itoa(num)
	digits := []byte(s)
	even := []int{}
	odd := []int{}
	for _, c := range digits {
		d := int(c - '0')
		if d%2 == 0 {
			even = append(even, d)
		} else {
			odd = append(odd, d)
		}
	}
	sort.Sort(sort.Reverse(sort.IntSlice(even)))
	sort.Sort(sort.Reverse(sort.IntSlice(odd)))
	ei, oi := 0, 0
	for i, c := range digits {
		d := int(c - '0')
		if d%2 == 0 {
			digits[i] = byte(even[ei] + '0')
			ei++
		} else {
			digits[i] = byte(odd[oi] + '0')
			oi++
		}
	}
	res, _ := strconv.Atoi(string(digits))
	return res
}