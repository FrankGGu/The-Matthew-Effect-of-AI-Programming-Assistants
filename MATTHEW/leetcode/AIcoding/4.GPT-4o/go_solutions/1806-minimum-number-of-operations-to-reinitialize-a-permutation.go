func reinitializePermutation(n int) int {
    original := make([]int, n)
    for i := 0; i < n; i++ {
        original[i] = i
    }

    perm := make([]int, n)
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            perm[i] = i / 2
        } else {
            perm[i] = n/2 + (i-1)/2
        }
    }

    operations := 0
    for !equal(original, perm) {
        operations++
        newPerm := make([]int, n)
        for i := 0; i < n; i++ {
            newPerm[i] = perm[perm[i]]
        }
        perm = newPerm
    }

    return operations
}

func equal(a, b []int) bool {
    for i := range a {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}