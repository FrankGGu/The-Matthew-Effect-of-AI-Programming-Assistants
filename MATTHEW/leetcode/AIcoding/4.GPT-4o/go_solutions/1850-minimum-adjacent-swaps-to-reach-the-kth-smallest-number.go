func getMinSwaps(num string, k int) int {
    n := len(num)
    target := nextPermutation(num)

    swaps := 0
    numBytes := []byte(num)
    targetBytes := []byte(target)

    for i := 0; i < n; i++ {
        if numBytes[i] != targetBytes[i] {
            swaps++
            for j := i + 1; j < n; j++ {
                if numBytes[j] == targetBytes[i] {
                    numBytes[j], numBytes[i] = numBytes[i], numBytes[j]
                    break
                }
            }
        }
    }

    return swaps
}

func nextPermutation(num string) string {
    n := len(num)
    numBytes := []byte(num)
    i := n - 2
    for i >= 0 && numBytes[i] >= numBytes[i+1] {
        i--
    }
    if i >= 0 {
        j := n - 1
        for numBytes[j] <= numBytes[i] {
            j--
        }
        numBytes[i], numBytes[j] = numBytes[j], numBytes[i]
    }
    reverse(numBytes, i+1)
    return string(numBytes)
}

func reverse(nums []byte, start int) {
    end := len(nums) - 1
    for start < end {
        nums[start], nums[end] = nums[end], nums[start]
        start++
        end--
    }
}