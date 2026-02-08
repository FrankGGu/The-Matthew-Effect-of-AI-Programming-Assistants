func isNStraightHand(hand []int, W int) bool {
    if len(hand)%W != 0 {
        return false
    }

    count := make(map[int]int)
    for _, num := range hand {
        count[num]++
    }

    keys := make([]int, 0, len(count))
    for k := range count {
        keys = append(keys, k)
    }
    sort.Ints(keys)

    for _, num := range keys {
        if count[num] == 0 {
            continue
        }
        cnt := count[num]
        for i := 0; i < W; i++ {
            if count[num+i] < cnt {
                return false
            }
            count[num+i] -= cnt
        }
    }

    return true
}