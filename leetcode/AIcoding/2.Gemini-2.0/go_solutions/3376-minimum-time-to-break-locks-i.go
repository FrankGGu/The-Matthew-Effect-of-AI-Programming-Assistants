import (
	"sort"
)

func minimumTimeToBreakLocks(locks []int, keyPressCost int, keyPressTime int) int {
	sort.Ints(locks)
	n := len(locks)
	if n == 0 {
		return 0
	}
	ans := 0
	ans += keyPressCost
	ans += keyPressTime
	for i := 1; i < n; i++ {
		if locks[i] != locks[i-1] {
			ans += keyPressCost
			ans += keyPressTime
		}
	}
	return ans
}