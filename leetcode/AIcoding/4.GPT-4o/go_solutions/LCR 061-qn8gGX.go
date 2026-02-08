import "container/heap"

func kSmallestPairs(nums1 []int, nums2 []int, k int) [][]int {
    if len(nums1) == 0 || len(nums2) == 0 || k == 0 {
        return [][]int{}
    }

    type pair struct {
        sum  int
        index1 int
        index2 int
    }

    minHeap := &[]pair{}
    for i := 0; i < len(nums1); i++ {
        for j := 0; j < len(nums2); j++ {
            heap.Push(minHeap, pair{sum: nums1[i] + nums2[j], index1: i, index2: j})
            if len(*minHeap) > k {
                heap.Pop(minHeap)
            }
        }
    }

    result := [][]int{}
    for _, p := range *minHeap {
        result = append(result, []int{nums1[p.index1], nums2[p.index2]})
    }

    return result
}