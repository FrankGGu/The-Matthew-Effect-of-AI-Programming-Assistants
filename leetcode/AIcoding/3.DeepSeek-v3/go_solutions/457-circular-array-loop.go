func circularArrayLoop(nums []int) bool {
    n := len(nums)
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            continue
        }
        slow, fast := i, i
        for {
            slow = next(nums, slow)
            fast = next(nums, fast)
            if nums[fast] * nums[i] <= 0 {
                break
            }
            fast = next(nums, fast)
            if nums[fast] * nums[i] <= 0 {
                break
            }
            if slow == fast {
                if slow == next(nums, slow) {
                    break
                }
                return true
            }
        }
        slow = i
        for nums[slow] * nums[i] > 0 {
            nextPos := next(nums, slow)
            nums[slow] = 0
            slow = nextPos
        }
    }
    return false
}

func next(nums []int, i int) int {
    n := len(nums)
    return ((i + nums[i]) % n + n) % n
}