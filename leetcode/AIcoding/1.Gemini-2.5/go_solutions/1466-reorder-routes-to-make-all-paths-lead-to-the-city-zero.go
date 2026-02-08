import "fmt"

func minReorder(n int, connections [][]int) int {
    adj := make([][][2]int, n)
    for _, conn := range connections {
        u, v := conn[0], conn[1]
        // For original edge u -> v, add (v, 1)