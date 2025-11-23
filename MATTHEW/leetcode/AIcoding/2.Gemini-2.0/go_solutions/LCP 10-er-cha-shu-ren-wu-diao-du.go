import (
	"fmt"
	"math"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func minimumTime(n int, relations [][]int, time []int) int {
	inDegree := make([]int, n)
	graph := make([][]int, n)
	for _, relation := range relations {
		prevCourse := relation[0] - 1
		nextCourse := relation[1] - 1
		graph[prevCourse] = append(graph[prevCourse], nextCourse)
		inDegree[nextCourse]++
	}

	maxTime := make([]int, n)
	for i := 0; i < n; i++ {
		maxTime[i] = time[i]
	}

	queue := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	ans := 0
	for len(queue) > 0 {
		course := queue[0]
		queue = queue[1:]
		ans = int(math.Max(float64(ans), float64(maxTime[course])))

		for _, nextCourse := range graph[course] {
			maxTime[nextCourse] = int(math.Max(float64(maxTime[nextCourse]), float64(maxTime[course]+time[nextCourse])))
			inDegree[nextCourse]--
			if inDegree[nextCourse] == 0 {
				queue = append(queue, nextCourse)
			}
		}
	}

	return ans
}