import "sort"

func findContentChildren(g []int, s []int) int {
	sort.Ints(g)
	sort.Ints(s)

	childIdx := 0
	cookieIdx := 0
	contentChildren := 0

	for childIdx < len(g) && cookieIdx < len(s) {
		if s[cookieIdx] >= g[childIdx] {
			contentChildren++
			childIdx++
		}
		cookieIdx++
	}

	return contentChildren
}