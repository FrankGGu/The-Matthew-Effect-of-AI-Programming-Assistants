package main

func isCircularArrayLoop(nums []int) bool {
    n := len(nums)
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            continue
        }
        direction := nums[i] > 0
        slow, fast := i, i
        for {
            slow = nextIndex(nums, slow, direction)
            if slow == -1 {
                break
            }
            fast = nextIndex(nums, fast, direction)
            if fast == -1 {
                break
            }
            fast = nextIndex(nums, fast, direction)
            if fast == -1 {
                break
            }
            if slow == fast {
                if slow == nextIndex(nums, slow, direction) {
                    continue
                }
                return true
            }
        }
        markAsVisited(nums, i)
    }
    return false
}

func nextIndex(nums []int, index int, direction bool) int {
    next := index + nums[index]
    if next >= len(nums) {
        next -= len(nums)
    } else if next < 0 {
        next += len(nums)
    }
    if next < 0 || next >= len(nums) {
        return -1
    }
    if (nums[next] > 0) != direction {
        return -1
    }
    return next
}

func markAsVisited(nums []int, start int) {
    direction := nums[start] > 0
    current := start
    for {
        next := nextIndex(nums, current, direction)
        if next == -1 || next == current {
            break
        }
        nums[current] = 0
        current = next
    }
    nums[current] = 0
}