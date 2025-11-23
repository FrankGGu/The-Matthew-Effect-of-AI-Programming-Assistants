func countSubarrays(nums []int, k int) int64 {
    maxNum := nums[0]
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    var res int64 = 0
    left := 0
    count := 0

    for right := 0; right < len(nums); right++ {
        if nums[right] == maxNum {
            count++
        }

        for count >= k {
            res += int64(len(nums) - right)
            if nums[left] == maxNum {
                count--
            }
            left++
        }
    }

    return res
}