package main

func getResultArray(nums []int, k int) []int {
    result := make([]int, len(nums))
    copy(result, nums)
    for i := 0; i < k; i++ {
        temp := make([]int, len(result))
        for j := 0; j < len(result); j++ {
            if j == 0 {
                temp[j] = result[j]
            } else {
                temp[j] = result[j-1] * result[j]
            }
        }
        result = temp
    }
    return result
}