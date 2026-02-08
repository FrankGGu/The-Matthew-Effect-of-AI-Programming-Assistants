func threeSumMulti(arr []int, target int) int {
    const mod = 1e9 + 7
    count := 0
    freq := make(map[int]int)
    for _, num := range arr {
        freq[num]++
    }
    keys := make([]int, 0, len(freq))
    for k := range freq {
        keys = append(keys, k)
    }
    sort.Ints(keys)
    n := len(keys)
    for i := 0; i < n; i++ {
        x := keys[i]
        newTarget := target - x
        j, k := i, n-1
        for j <= k {
            y, z := keys[j], keys[k]
            if y + z < newTarget {
                j++
            } else if y + z > newTarget {
                k--
            } else {
                if i < j && j < k {
                    count += freq[x] * freq[y] * freq[z]
                } else if i == j && j < k {
                    count += freq[x] * (freq[x] - 1) / 2 * freq[z]
                } else if i < j && j == k {
                    count += freq[x] * freq[y] * (freq[y] - 1) / 2
                } else {
                    count += freq[x] * (freq[x] - 1) * (freq[x] - 2) / 6
                }
                count %= mod
                j++
                k--
            }
        }
    }
    return count
}