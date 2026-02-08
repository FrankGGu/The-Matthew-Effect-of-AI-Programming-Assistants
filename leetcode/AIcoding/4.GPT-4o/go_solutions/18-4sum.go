import "sort"

func fourSum(nums []int, target int) [][]int {
    sort.Ints(nums)
    var result [][]int
    n := len(nums)

    for i := 0; i < n-3; i++ {
        if i > 0 && nums[i] == nums[i-1] {
            continue
        }
        for j := i + 1; j < n-2; j++ {
            if j > i+1 && nums[j] == nums[j-1] {
                continue
            }
            left, right := j + 1, n - 1
            for left < right {
                sum := nums[i] + nums[j] + nums[left] + nums[right]
                if sum < target {
                    left++
                } else if sum > target {
                    right--
                } else {
                    result = append(result, []int{nums[i], nums[j], nums[left], nums[right]})
                    for left < right && nums[left] == nums[left+1] {
                        left++
                    }
                    for left < right && nums[right] == nums[right-1] {
                        right--
                    }
                    left++
                    right--
                }
            }
        }
    }
    return result
}