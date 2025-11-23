package main

func medianSlidingWindow(nums []int, k int) []float64 {
    n := len(nums)
    res := make([]float64, 0, n-k+1)
    left := make([]int, 0, k)
    right := make([]int, 0, k)

    for i := 0; i < k; i++ {
        if len(left) == 0 || nums[i] <= left[0] {
            left = append(left, nums[i])
        } else {
            right = append(right, nums[i])
        }
    }

    for len(left) > len(right)+1 {
        right = append(right, left[len(left)-1])
        left = left[:len(left)-1]
    }

    for len(right) > len(left) {
        left = append(left, right[0])
        right = right[1:]
    }

    for i := k; i <= n; i++ {
        if k%2 == 1 {
            res = append(res, float64(left[0]))
        } else {
            res = append(res, float64(left[0]+right[0])/2)
        }

        if i == n {
            break
        }

        if nums[i] <= left[0] {
            left = append(left, nums[i])
        } else {
            right = append(right, nums[i])
        }

        if nums[i-k] <= left[0] {
            left = left[1:]
        } else {
            right = right[1:]
        }

        for len(left) > len(right)+1 {
            right = append(right, left[len(left)-1])
            left = left[:len(left)-1]
        }

        for len(right) > len(left) {
            left = append(left, right[0])
            right = right[1:]
        }
    }

    return res
}