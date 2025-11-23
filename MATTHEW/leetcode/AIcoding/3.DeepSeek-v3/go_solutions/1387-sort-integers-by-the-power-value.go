func getKth(lo int, hi int, k int) int {
    power := make(map[int]int)
    var computePower func(x int) int
    computePower = func(x int) int {
        if val, ok := power[x]; ok {
            return val
        }
        if x == 1 {
            return 0
        }
        var next int
        if x%2 == 0 {
            next = x / 2
        } else {
            next = 3*x + 1
        }
        res := 1 + computePower(next)
        power[x] = res
        return res
    }

    nums := make([]int, hi-lo+1)
    for i := 0; i <= hi-lo; i++ {
        nums[i] = lo + i
    }

    sort.Slice(nums, func(i, j int) bool {
        pi := computePower(nums[i])
        pj := computePower(nums[j])
        if pi == pj {
            return nums[i] < nums[j]
        }
        return pi < pj
    })

    return nums[k-1]
}