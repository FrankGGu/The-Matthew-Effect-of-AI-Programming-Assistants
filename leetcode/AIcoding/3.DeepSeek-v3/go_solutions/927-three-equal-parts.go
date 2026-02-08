func threeEqualParts(arr []int) []int {
    count := 0
    for _, num := range arr {
        if num == 1 {
            count++
        }
    }
    if count == 0 {
        return []int{0, 2}
    }
    if count%3 != 0 {
        return []int{-1, -1}
    }
    k := count / 3
    pos := make([]int, 0)
    sum := 0
    for i, num := range arr {
        if num == 1 {
            sum++
            if sum == 1 || sum == k+1 || sum == 2*k+1 {
                pos = append(pos, i)
            }
        }
    }
    i, j, l := pos[0], pos[1], pos[2]
    for l < len(arr) {
        if arr[i] != arr[j] || arr[j] != arr[l] {
            return []int{-1, -1}
        }
        i++
        j++
        l++
    }
    return []int{i - 1, j}
}