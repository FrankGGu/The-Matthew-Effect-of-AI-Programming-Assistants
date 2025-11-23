func beautifulSubsets(nums []int, k int) int {
    n := len(nums)
    count := 0

    var backtrack func(index int, subset []int)
    backtrack = func(index int, subset []int) {
        if index == n {
            if len(subset) > 0 {
                valid := true
                for i := 0; i < len(subset); i++ {
                    for j := i + 1; j < len(subset); j++ {
                        if abs(subset[i]-subset[j]) == k {
                            valid = false
                            break
                        }
                    }
                    if !valid {
                        break
                    }
                }
                if valid {
                    count++
                }
            }
            return
        }

        // Include nums[index]
        backtrack(index+1, append(subset, nums[index]))
        // Exclude nums[index]
        backtrack(index+1, subset)
    }

    backtrack(0, []int{})
    return count
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}