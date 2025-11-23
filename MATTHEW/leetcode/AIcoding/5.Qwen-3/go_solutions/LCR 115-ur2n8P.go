package main

func canReorderDoubled(nums []int) bool {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    keys := make([]int, 0, len(count))
    for k := range count {
        keys = append(keys, k)
    }

    if len(keys) == 0 {
        return true
    }

    if count[0] % 2 != 0 {
        return false
    }

    sort.Ints(keys)

    for _, key := range keys {
        if key == 0 {
            continue
        }
        if count[key] > 0 {
            if count[key*2] < count[key] {
                return false
            }
            count[key*2] -= count[key]
            count[key] = 0
        }
    }

    return true
}