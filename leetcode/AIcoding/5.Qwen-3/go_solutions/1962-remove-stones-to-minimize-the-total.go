package main

func removeStones(piles []int, k int) int {
    heap := make([]int, len(piles))
    copy(heap, piles)
    for i := len(heap)/2 - 1; i >= 0; i-- {
        heapify(heap, i)
    }

    for k > 0 {
        max := heap[0]
        heap[0] = 0
        heapify(heap, 0)
        k--
    }

    sum := 0
    for _, v := range heap {
        sum += v
    }
    return sum
}

func heapify(heap []int, i int) {
    left := 2*i + 1
    right := 2*i + 2
    largest := i
    if left < len(heap) && heap[left] > heap[largest] {
        largest = left
    }
    if right < len(heap) && heap[right] > heap[largest] {
        largest = right
    }
    if largest != i {
        heap[i], heap[largest] = heap[largest], heap[i]
        heapify(heap, largest)
    }
}