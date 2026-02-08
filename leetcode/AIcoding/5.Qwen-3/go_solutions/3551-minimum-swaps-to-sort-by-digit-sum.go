package main

func minimumSwapsToSortByDigitSum(nums []int) int {
    n := len(nums)
    sumDigits := func(x int) int {
        s := 0
        for x > 0 {
            s += x % 10
            x /= 10
        }
        return s
    }

    type pair struct {
        val, idx int
    }

    arr := make([]pair, n)
    for i := range nums {
        arr[i] = pair{nums[i], i}
    }

    sort.Slice(arr, func(i, j int) bool {
        if sumDigits(arr[i].val) != sumDigits(arr[j].val) {
            return sumDigits(arr[i].val) < sumDigits(arr[j].val)
        }
        return arr[i].val < arr[j].val
    })

    visited := make([]bool, n)
    result := 0

    for i := 0; i < n; i++ {
        if visited[i] {
            continue
        }

        cycleSize := 0
        j := i
        for !visited[j] {
            visited[j] = true
            j = arr[j].idx
            cycleSize++
        }

        if cycleSize > 1 {
            result += cycleSize - 1
        }
    }

    return result
}