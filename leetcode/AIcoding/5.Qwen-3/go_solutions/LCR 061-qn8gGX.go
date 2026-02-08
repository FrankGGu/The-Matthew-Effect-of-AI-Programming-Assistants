package main

func kSmallestPairs(nums1 []int, nums2 []int, k int) [][]int {
    if len(nums1) == 0 || len(nums2) == 0 {
        return [][]int{}
    }

    heap := make([][]int, 0)
    for i := 0; i < len(nums1); i++ {
        heap = append(heap, []int{nums1[i] + nums2[0], 0, i})
    }

    result := make([][]int, 0)
    for len(heap) > 0 && len(result) < k {
        val := heap[0]
        heap = append(heap[:0], heap[1:]...)
        i, j := val[2], val[1]
        result = append(result, []int{nums1[i], nums2[j]})

        if j+1 < len(nums2) {
            newSum := nums1[i] + nums2[j+1]
            insert(heap, []int{newSum, j + 1, i})
        }
    }

    return result
}

func insert(heap [][]int, val []int) {
    heap = append(heap, val)
    i := len(heap) - 1
    for i > 0 {
        parent := (i - 1) / 2
        if heap[parent][0] <= heap[i][0] {
            break
        }
        heap[parent], heap[i] = heap[i], heap[parent]
        i = parent
    }
}