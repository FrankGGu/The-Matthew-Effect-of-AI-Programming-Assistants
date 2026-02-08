type Worker struct {
    leftToRight int
    pickOld     int
    rightToLeft int
    putNew      int
    idx         int
}

type WorkerHeap []Worker

func (h WorkerHeap) Len() int { return len(h) }
func (h WorkerHeap) Less(i, j int) bool {
    if h[i].leftToRight+h[i].rightToLeft == h[j].leftToRight+h[j].rightToLeft {
        return h[i].idx < h[j].idx
    }
    return h[i].leftToRight+h[i].rightToLeft < h[j].leftToRight+h[j].rightToLeft
}
func (h WorkerHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }
func (h *WorkerHeap) Push(x interface{}) { *h = append(*h, x.(Worker)) }
func (h *WorkerHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func findCrossingTime(n int, k int, time [][]int) int {
    workers := make([]Worker, k)
    for i := 0; i < k; i++ {
        workers[i] = Worker{
            leftToRight: time[i][0],
            pickOld:     time[i][1],
            rightToLeft: time[i][2],
            putNew:      time[i][3],
            idx:         i,
        }
    }

    leftBank := &WorkerHeap{}
    rightBank := &WorkerHeap{}
    heap.Init(leftBank)
    heap.Init(rightBank)

    for i := 0; i < k; i++ {
        heap.Push(leftBank, workers[i])
    }

    workLeft := make([][2]int, 0)
    workRight := make([][2]int, 0)

    currentTime := 0
    remainingBoxes := n

    for remainingBoxes > 0 || workRight != nil || rightBank.Len() > 0 {
        for len(workLeft) > 0 && workLeft[0][0] <= currentTime {
            worker := workers[workLeft[0][1]]
            heap.Push(leftBank, worker)
            workLeft = workLeft[1:]
        }

        for len(workRight) > 0 && workRight[0][0] <= currentTime {
            worker := workers[workRight[0][1]]
            heap.Push(rightBank, worker)
            workRight = workRight[1:]
        }

        if rightBank.Len() > 0 {
            worker := heap.Pop(rightBank).(Worker)
            currentTime += worker.rightToLeft
            workLeft = append(workLeft, [2]int{currentTime + worker.putNew, worker.idx})
        } else if leftBank.Len() > 0 && remainingBoxes > 0 {
            worker := heap.Pop(leftBank).(Worker)
            currentTime += worker.leftToRight
            workRight = append(workRight, [2]int{currentTime + worker.pickOld, worker.idx})
            remainingBoxes--
        } else {
            nextEvent := 1 << 31 - 1
            if len(workLeft) > 0 {
                nextEvent = workLeft[0][0]
            }
            if len(workRight) > 0 && workRight[0][0] < nextEvent {
                nextEvent = workRight[0][0]
            }
            if nextEvent != 1<<31-1 {
                currentTime = nextEvent
            }
        }
    }

    return currentTime
}