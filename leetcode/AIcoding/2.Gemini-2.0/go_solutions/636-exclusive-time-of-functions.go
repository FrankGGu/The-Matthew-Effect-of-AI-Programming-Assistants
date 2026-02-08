import (
	"strconv"
	"strings"
)

func exclusiveTime(n int, logs []string) []int {
	stack := []int{}
	res := make([]int, n)
	prevTime := 0
	for _, log := range logs {
		parts := strings.Split(log, ":")
		id, _ := strconv.Atoi(parts[0])
		action := parts[1]
		time, _ := strconv.Atoi(parts[2])

		if action == "start" {
			if len(stack) > 0 {
				res[stack[len(stack)-1]] += time - prevTime
			}
			stack = append(stack, id)
			prevTime = time
		} else {
			res[id] += time - prevTime + 1
			prevTime = time + 1
			stack = stack[:len(stack)-1]
		}
	}
	return res
}