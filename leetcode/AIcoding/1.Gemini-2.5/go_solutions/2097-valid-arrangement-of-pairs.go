import "sort"

func validArrangement(pairs [][]int) [][]int {
	adj := make(map[int][]int)
	inDegree := make(map[int]int)
	outDegree := make(map[int]int)

	for _, pair := range pairs {
		u, v := pair[0