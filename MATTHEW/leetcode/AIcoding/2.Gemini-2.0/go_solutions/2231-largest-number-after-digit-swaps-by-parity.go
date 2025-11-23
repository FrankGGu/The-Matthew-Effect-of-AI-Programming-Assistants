import "sort"

func largestInteger(num int) int {
	s := strconv.Itoa(num)
	n := len(s)
	odd := []int{}
	even := []int{}
	for i := 0; i < n; i++ {
		digit, _ := strconv.Atoi(string(s[i]))
		if digit%2 == 0 {
			even = append(even, digit)
		} else {
			odd = append(odd, digit)
		}
	}
	sort.Sort(sort.Reverse(sort.IntSlice(odd)))
	sort.Sort(sort.Reverse(sort.IntSlice(even)))
	oddIdx := 0
	evenIdx := 0
	res := ""
	for i := 0; i < n; i++ {
		digit, _ := strconv.Atoi(string(s[i]))
		if digit%2 == 0 {
			res += strconv.Itoa(even[evenIdx])
			evenIdx++
		} else {
			res += strconv.Itoa(odd[oddIdx])
			oddIdx++
		}
	}
	ans, _ := strconv.Atoi(res)
	return ans
}