func gcdSort(nums []int) bool {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    spf := make([]int, maxNum+1)
    for i := 2; i <= maxNum; i++ {
        if spf[i] == 0 {
            spf[i] = i
            for j := i * i; j <= maxNum; j += i {
                if spf[j] == 0 {
                    spf[j] = i
                }
            }
        }
    }

    parent := make([]int, maxNum+1)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    union := func(u, v int) {
        pu, pv := find(u), find(v)
        if pu != pv {
            parent[pu] = pv
        }
    }

    for _, num := range nums {
        if num == 1 {
            continue
        }
        x := num
        factors := []int{}
        for x > 1 {
            p := spf[x]
            factors = append(factors, p)
            for x%p == 0 {
                x /= p
            }
        }
        for i := 1; i < len(factors); i++ {
            union(factors[0], factors[i])
        }
    }

    sorted := make([]int, len(nums))
    copy(sorted, nums)
    sort.Ints(sorted)

    for i := 0; i < len(nums); i++ {
        if nums[i] == sorted[i] {
            continue
        }
        if find(nums[i]) != find(sorted[i]) {
            return false
        }
    }
    return true
}