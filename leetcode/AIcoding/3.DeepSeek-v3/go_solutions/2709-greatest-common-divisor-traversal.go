func canTraverseAllPairs(nums []int) bool {
    if len(nums) == 1 {
        return true
    }

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
            return false
        }
        x := num
        factors := make(map[int]bool)
        for x > 1 {
            p := spf[x]
            factors[p] = true
            for x % p == 0 {
                x /= p
            }
        }
        primes := make([]int, 0, len(factors))
        for p := range factors {
            primes = append(primes, p)
        }
        for i := 1; i < len(primes); i++ {
            union(primes[i-1], primes[i])
        }
    }

    root := -1
    for _, num := range nums {
        if num == 1 {
            return false
        }
        p := spf[num]
        if root == -1 {
            root = find(p)
        } else if find(p) != root {
            return false
        }
    }

    return true
}