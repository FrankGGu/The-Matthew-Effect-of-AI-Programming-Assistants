func oddEvenJumps(arr []int) int {
    n := len(arr)
    if n == 0 {
        return 0
    }

    nextHigher := make([]int, n)
    nextLower := make([]int, n)

    for i := range nextHigher {
        nextHigher[i] = -1
        nextLower[i] = -1
    }

    stack := make([]int, 0)
    sortedIndices := make([]int, n)
    for i := range sortedIndices {
        sortedIndices[i] = i
    }

    sort.Slice(sortedIndices, func(i, j int) bool {
        if arr[sortedIndices[i]] == arr[sortedIndices[j]] {
            return sortedIndices[i] < sortedIndices[j]
        }
        return arr[sortedIndices[i]] < arr[sortedIndices[j]]
    })

    for _, i := range sortedIndices {
        for len(stack) > 0 && i > stack[len(stack)-1] {
            nextHigher[stack[len(stack)-1]] = i
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, i)
    }

    stack = stack[:0]
    sort.Slice(sortedIndices, func(i, j int) bool {
        if arr[sortedIndices[i]] == arr[sortedIndices[j]] {
            return sortedIndices[i] < sortedIndices[j]
        }
        return arr[sortedIndices[i]] > arr[sortedIndices[j]]
    })

    for _, i := range sortedIndices {
        for len(stack) > 0 && i > stack[len(stack)-1] {
            nextLower[stack[len(stack)-1]] = i
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, i)
    }

    higher := make([]bool, n)
    lower := make([]bool, n)
    higher[n-1] = true
    lower[n-1] = true
    res := 1

    for i := n - 2; i >= 0; i-- {
        if nextHigher[i] != -1 {
            higher[i] = lower[nextHigher[i]]
        }
        if nextLower[i] != -1 {
            lower[i] = higher[nextLower[i]]
        }
        if higher[i] {
            res++
        }
    }

    return res
}