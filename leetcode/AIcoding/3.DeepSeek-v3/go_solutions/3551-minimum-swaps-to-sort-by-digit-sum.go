func minimumSwaps(nums []int) int {
    n := len(nums)
    digitSums := make([]int, n)
    for i, num := range nums {
        sum := 0
        tmp := num
        for tmp > 0 {
            sum += tmp % 10
            tmp /= 10
        }
        digitSums[i] = sum
    }

    indices := make([]int, n)
    for i := range indices {
        indices[i] = i
    }

    sort.Slice(indices, func(i, j int) bool {
        if digitSums[indices[i]] == digitSums[indices[j]] {
            return indices[i] < indices[j]
        }
        return digitSums[indices[i]] < digitSums[indices[j]]
    })

    visited := make([]bool, n)
    swaps := 0

    for i := 0; i < n; i++ {
        if visited[i] || indices[i] == i {
            continue
        }

        cycleSize := 0
        j := i
        for !visited[j] {
            visited[j] = true
            j = indices[j]
            cycleSize++
        }

        if cycleSize > 0 {
            swaps += cycleSize - 1
        }
    }

    return swaps
}