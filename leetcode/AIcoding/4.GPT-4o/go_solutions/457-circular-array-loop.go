func circularArrayLoop(nums []int) bool {
    n := len(nums)
    for i := 0; i < n; i++ {
        slow, fast := i, i
        isForward := nums[i] > 0
        for {
            slow = nextIndex(nums, slow, isForward)
            fast = nextIndex(nums, nextIndex(nums, fast, isForward), isForward)
            if slow == -1 || fast == -1 || slow == fast {
                break
            }
        }
        if slow != -1 && slow == fast {
            return true
        }
    }
    return false
}

func nextIndex(nums []int, current int, isForward bool) int {
    direction := nums[current] > 0
    if direction != isForward {
        return -1
    }
    next := (current + nums[current]) % len(nums)
    if next < 0 {
        next += len(nums)
    }
    if next == current {
        return -1
    }
    return next
}