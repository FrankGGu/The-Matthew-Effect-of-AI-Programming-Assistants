func missingInteger(nums []int) int {
    sum := nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i] != nums[i-1]+1 {
            break
        }
        sum += nums[i]
    }

    set := make(map[int]bool)
    for _, num := range nums {
        set[num] = true
    }

    for {
        if !set[sum] {
            return sum
        }
        sum++
    }
}