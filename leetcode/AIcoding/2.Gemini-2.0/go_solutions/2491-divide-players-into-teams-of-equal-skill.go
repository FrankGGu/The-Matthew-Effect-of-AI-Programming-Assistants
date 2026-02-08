import (
	"sort"
)

func dividePlayers(skill []int) int64 {
	n := len(skill)
	sort.Ints(skill)
	sum := skill[0] + skill[n-1]
	res := int64(0)
	for i := 0; i < n/2; i++ {
		if skill[i]+skill[n-1-i] != sum {
			return -1
		}
		res += int64(skill[i] * skill[n-1-i])
	}
	return res
}