package main

func kSum(nums []int, k int) int {
    sort.Ints(nums)
    sum := 0
    for _, num := range nums {
        sum += num
    }
    maxHeap := make([]int, 0)
    maxHeap = append(maxHeap, sum)
    for i := 0; i < len(nums); i++ {
        newHeap := make([]int, 0)
        for j := 0; j < len(maxHeap); j++ {
            newHeap = append(newHeap, maxHeap[j]-nums[i])
        }
        maxHeap = append(maxHeap, newHeap...)
        sort.Sort(sort.Reverse(sort.IntSlice(maxHeap)))
        if len(maxHeap) > k {
            maxHeap = maxHeap[:k]
        }
    }
    return maxHeap[k-1]
}