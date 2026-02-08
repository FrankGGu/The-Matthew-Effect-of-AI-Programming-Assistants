func threeSumMulti(arr []int, target int) int {
    const mod = 1_000_000_007
    count := make(map[int]int)
    for _, num := range arr {
        count[num]++
    }

    keys := []int{}
    for k := range count {
        keys = append(keys, k)
    }

    result := 0
    n := len(keys)

    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            k := target - keys[i] - keys[j]
            if _, exists := count[k]; exists {
                if i == j && j == keys.index(k) {
                    result = (result + count[keys[i]]*(count[keys[i]]-1)*(count[keys[i]]-2)/6) % mod) % mod
                } else if i == j {
                    result = (result + count[keys[i]]*(count[keys[i]]-1)/2*count[k]) % mod
                } else if j < n && keys[j] == k {
                    result = (result + count[keys[i]]*count[keys[j]]*(count[keys[j]]-1)/2) % mod
                } else {
                    result = (result + count[keys[i]]*count[keys[j]]*count[k]) % mod
                }
            }
        }
    }

    return result
}