package main

func maxScore(nums1 []int, nums2 []int, k int) int64 {
    pairs := make([][2]int, len(nums1))
    for i := range nums1 {
        pairs[i] = [2]int{nums1[i], nums2[i]}
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][1] > pairs[j][1]
    })

    heap := make([]int, 0, k)
    sum := 0
    for i := 0; i < k; i++ {
        sum += pairs[i][0]
        heap = append(heap, pairs[i][0])
    }
    heapify(heap)

    maxScore := int64(sum * pairs[k-1][1])

    for i := k; i < len(nums1); i++ {
        if pairs[i][0] > heap[0] {
            sum -= heap[0]
            sum += pairs[i][0]
            heap[0] = pairs[i][0]
            heapify(heap)
        }
        currentScore := sum * pairs[i][1]
        if currentScore > maxScore {
            maxScore = int64(currentScore)
        }
    }

    return maxScore
}

func heapify(h []int) {
    for i := len(h) / 2 - 1; i >= 0; i-- {
        siftDown(h, i)
    }
}

func siftDown(h []int, i int) {
    for {
        left := 2*i + 1
        right := 2*i + 2
        smallest := i
        if left < len(h) && h[left] < h[smallest] {
            smallest = left
        }
        if right < len(h) && h[right] < h[smallest] {
            smallest = right
        }
        if smallest == i {
            break
        }
        h[i], h[smallest] = h[smallest], h[i]
        i = smallest
    }
}