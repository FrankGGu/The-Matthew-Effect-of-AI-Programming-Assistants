func minimumTime(tasks []int, workers []int) int {
    sort.Ints(tasks)
    sort.Ints(workers)
    n := len(tasks)
    m := len(workers)
    left := 0
    right := tasks[n-1]
    ans := right

    check := func(time int) bool {
        j := m - 1
        completed := 0
        for i := n - 1; i >= 0; i-- {
            for j >= 0 && workers[j] * time < tasks[i] {
                j--
            }
            if j >= 0 {
                completed++
                j--
            }
        }
        return completed >= n
    }

    for left <= right {
        mid := left + (right-left)/2
        if check(mid) {
            ans = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return ans
}