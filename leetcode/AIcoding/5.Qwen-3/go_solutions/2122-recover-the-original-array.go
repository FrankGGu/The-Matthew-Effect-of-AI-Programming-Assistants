package main

func recoverArray(target []int) []int {
    sort.Ints(target)
    n := len(target)
    freq := make(map[int]int)
    for _, num := range target {
        freq[num]++
    }
    res := make([]int, 0)
    for i := 1; i < n; i++ {
        if target[i] == target[i-1] {
            continue
        }
        diff := target[i] - target[0]
        if diff == 0 {
            continue
        }
        temp := make([]int, 0)
        used := make(map[int]bool)
        valid := true
        for j := 0; j < n; j++ {
            if used[target[j]] {
                continue
            }
            if freq[target[j]+diff] == 0 {
                valid = false
                break
            }
            temp = append(temp, target[j])
            used[target[j]] = true
            freq[target[j]]--
            freq[target[j]+diff]--
        }
        if valid {
            return temp
        }
        for j := 0; j < n; j++ {
            freq[target[j]]++
        }
    }
    return res
}