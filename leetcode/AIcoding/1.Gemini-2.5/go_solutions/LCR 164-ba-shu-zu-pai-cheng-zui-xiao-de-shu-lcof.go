var visited map[string]bool
var resultBuilder strings.Builder
var N int
var K int

func crackSafe(n int, k int) string {
	N = n
	K = k
	visited = make(map[string]bool)
	resultBuilder.Reset