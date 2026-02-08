func getMinSwaps(num string, k int) int {
    digits := []byte(num)
    original := make([]byte, len(digits))
    copy(original, digits)

    for i := 0; i < k; i++ {
        nextPermutation(digits)
    }

    res := 0
    for i := 0; i < len(digits); i++ {
        if digits[i] == original[i] {
            continue
        }
        j := i + 1
        for j < len(digits) && original[j] != digits[i] {
            j++
        }
        for j > i {
            original[j], original[j-1] = original[j-1], original[j]
            res++
            j--
        }
    }
    return res
}

func nextPermutation(nums []byte) {
    n := len(nums)
    i := n - 2
    for i >= 0 && nums[i] >= nums[i+1] {
        i--
    }
    if i >= 0 {
        j := n - 1
        for j >= 0 && nums[j] <= nums[i] {
            j--
        }
        nums[i], nums[j] = nums[j], nums[i]
    }
    reverse(nums[i+1:])
}

func reverse(nums []byte) {
    for i, j := 0, len(nums)-1; i < j; i, j = i+1, j-1 {
        nums[i], nums[j] = nums[j], nums[i]
    }
}