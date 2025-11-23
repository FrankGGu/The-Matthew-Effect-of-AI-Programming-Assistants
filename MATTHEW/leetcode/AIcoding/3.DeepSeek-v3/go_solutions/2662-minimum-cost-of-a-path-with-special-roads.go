type Point struct {
    x, y int
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func minimumCost(start []int, target []int, specialRoads [][]int) int {
    startPoint := Point{start[0], start[1]}
    targetPoint := Point{target[0], target[1]}

    dist := make(map[Point]int)
    dist[startPoint] = 0
    heap := &Heap{}
    heap.Push(HeapItem{startPoint, 0})

    for heap.Len() > 0 {
        item := heap.Pop()
        current := item.p
        currentCost := item.cost

        if current == targetPoint {
            return currentCost
        }

        if currentCost > dist[current] {
            continue
        }

        for _, road := range specialRoads {
            a := Point{road[0], road[1]}
            b := Point{road[2], road[3]}
            cost := road[4]

            newCost := currentCost + abs(current.x-a.x) + abs(current.y-a.y) + cost
            if val, exists := dist[b]; !exists || newCost < val {
                dist[b] = newCost
                heap.Push(HeapItem{b, newCost})
            }
        }

        newCost := currentCost + abs(current.x-targetPoint.x) + abs(current.y-targetPoint.y)
        if val, exists := dist[targetPoint]; !exists || newCost < val {
            dist[targetPoint] = newCost
            heap.Push(HeapItem{targetPoint, newCost})
        }
    }

    return -1
}

type HeapItem struct {
    p    Point
    cost int
}

type Heap []HeapItem

func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i].cost < h[j].cost }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Heap) Push(x interface{}) {
    *h = append(*h, x.(HeapItem))
}

func (h *Heap) Pop() interface{} {
    old := *h
    n := len(old)
    item := old[n-1]
    *h = old[0 : n-1]
    return item
}