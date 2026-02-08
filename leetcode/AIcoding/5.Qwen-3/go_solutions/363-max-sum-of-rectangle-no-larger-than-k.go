package main

func maxSumSubmatrix(matrix [][]int, k int) int {
    rows, cols := len(matrix), len(matrix[0])
    maxSum := -1 << 63

    for left := 0; left < cols; left++ {
        rowSums := make([]int, rows)
        for right := left; right < cols; right++ {
            for i := 0; i < rows; i++ {
                rowSums[i] += matrix[i][right]
            }

            sorted := make([]int, 0)
            sorted = append(sorted, 0)
            currentSum := 0
            for _, v := range rowSums {
                currentSum += v
                idx := search(sorted, currentSum-k)
                if idx < len(sorted) {
                    maxSum = max(maxSum, currentSum - sorted[idx])
                }
                insert(sorted, currentSum)
            }
        }
    }
    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func search(nums []int, target int) int {
    l, r := 0, len(nums)-1
    for l <= r {
        mid := l + (r-l)/2
        if nums[mid] >= target {
            r = mid - 1
        } else {
            l = mid + 1
        }
    }
    return l
}

func insert(nums []int, val int) {
    l, r := 0, len(nums)-1
    for l <= r {
        mid := l + (r-l)/2
        if nums[mid] < val {
            l = mid + 1
        } else {
            r = mid - 1
        }
    }
    nums = append(nums, 0)
    for i := len(nums) - 1; i > l; i-- {
        nums[i] = nums[i-1]
    }
    nums[l] = val
}