import "fmt"

func maximumScoreAfterOperations(values []int, edges [][]int) int64 {
	n := len(values)
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u]