import "sort"

func numFriendRequests(ages []int) int {
	sort.Ints(ages)
	n := len(ages)
	ans := 0
	for i, age := range ages {
		if age < 15 {
			continue
		}
		l := sort.SearchInts(ages, age/2+7+1)
		r := sort.SearchInts(ages, age+1)
		ans += r - l - 1
	}
	return ans
}