func findDuplicate(nums []int) int {
    slow, fast := nums[0], nums[0]
    // Finding the intersection point
    for {
        slow = nums[slow]
        fast = nums[nums[fast]]
        if slow == fast {
            break
        }
    }
    // Finding the entrance to the cycle
    slow = nums[0]
    while slow != fast {
        slow = nums[slow]
        fast = nums[fast]
    }
    return slow
}