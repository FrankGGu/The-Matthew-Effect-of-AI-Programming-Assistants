package main

type MedianFinder struct {
    left  []int
    right []int
}

func Constructor() MedianFinder {
    return MedianFinder{
        left:  make([]int, 0),
        right: make([]int, 0),
    }
}

func (this *MedianFinder) AddNum(num int) {
    if len(this.left) == 0 || num <= this.left[0] {
        this.left = append(this.left, num)
        heapifyDown(this.left)
    } else {
        this.right = append(this.right, num)
        heapifyDown(this.right)
    }

    // Balance the heaps
    if len(this.left) > len(this.right)+1 {
        val := this.left[0]
        this.left = this.left[1:]
        this.right = append(this.right, val)
        heapifyDown(this.right)
    } else if len(this.right) > len(this.left) {
        val := this.right[0]
        this.right = this.right[1:]
        this.left = append(this.left, val)
        heapifyDown(this.left)
    }
}

func (this *MedianFinder) FindMedian() float64 {
    if len(this.left) == len(this.right) {
        return float64(this.left[0]+this.right[0]) / 2.0
    }
    return float64(this.left[0])
}

func heapifyDown(heap []int) {
    i := 0
    for {
        left := 2*i + 1
        right := 2*i + 2
        smallest := i
        if left < len(heap) && heap[left] < heap[smallest] {
            smallest = left
        }
        if right < len(heap) && heap[right] < heap[smallest] {
            smallest = right
        }
        if smallest != i {
            heap[i], heap[smallest] = heap[smallest], heap[i]
            i = smallest
        } else {
            break
        }
    }
}