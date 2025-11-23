import (
	"container/heap"
	"sort"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func smallestChair(times [][]int, targetFriend int) int {
	n := len(times)
	arrivals := make([]int, n)
	for i := 0; i < n; i++ {
		arrivals[i] = times[i][0]
	}

	sortedArrivals := make([]int, n)
	copy(sortedArrivals, arrivals)
	sort.Ints(sortedArrivals)

	arrivalMap := make(map[int]int)
	for i := 0; i < n; i++ {
		arrivalMap[times[i][0]] = i
	}

	availableChairs := &IntHeap{}
	heap.Init(availableChairs)

	occupied := make(map[int]int)

	for _, arrivalTime := range sortedArrivals {
		friendIndex := arrivalMap[arrivalTime]

		// Free up chairs
		for chair, departureTime := range occupied {
			if departureTime <= arrivalTime {
				heap.Push(availableChairs, chair)
				delete(occupied, chair)
			}
		}

		// Assign a chair
		var chair int
		if availableChairs.Len() > 0 {
			chair = heap.Pop(availableChairs).(int)
		} else {
			chair = len(occupied)
		}

		if friendIndex == targetFriend {
			return chair
		}

		occupied[chair] = times[friendIndex][1]
	}

	return -1 // Should never happen
}