package main

func wiggleSort(nums []int) {
    numsCopy := make([]int, len(nums))
    copy(numsCopy, nums)
    sort.Ints(numsCopy)
    i, j, k := 0, len(nums)-1, 0
    for k < len(nums) {
        if k%2 == 0 {
            nums[k] = numsCopy[i]
            i++
        } else {
            nums[k] = numsCopy[j]
            j--
        }
        k++
    }
}