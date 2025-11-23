import "container/heap"

type Node struct {
    lock   string
    steps  int
}

type MinHeap []Node

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].steps < h[j].steps }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(Node))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func openLock(deadends []string, target string) int {
    dead := make(map[string]struct{})
    for _, d := range deadends {
        dead[d] = struct{}{}
    }

    if _, ok := dead["0000"]; ok {
        return -1
    }
    if target == "0000" {
        return 0
    }

    visited := make(map[string]struct{})
    minHeap := &MinHeap{}
    heap.Push(minHeap, Node{"0000", 0})
    visited["0000"] = struct{}{}

    directions := []int{1, -1}

    for minHeap.Len() > 0 {
        node := heap.Pop(minHeap).(Node)

        for i := 0; i < 4; i++ {
            for _, dir := range directions {
                next := []byte(node.lock)
                next[i] = byte((int(next[i]-'0')+dir+10)%10 + '0')
                nextLock := string(next)

                if _, ok := dead[nextLock]; !ok {
                    if _, seen := visited[nextLock]; !seen {
                        if nextLock == target {
                            return node.steps + 1
                        }
                        visited[nextLock] = struct{}{}
                        heap.Push(minHeap, Node{nextLock, node.steps + 1})
                    }
                }
            }
        }
    }
    return -1
}