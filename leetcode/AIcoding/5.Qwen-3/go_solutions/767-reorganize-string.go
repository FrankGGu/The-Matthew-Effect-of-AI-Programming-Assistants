package main

func reorganizeString(s string) string {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }

    var maxHeap [][2]int
    for c, cnt := range count {
        maxHeap = append(maxHeap, [2]int{cnt, int(c)})
    }

    sort.Slice(maxHeap, func(i, j int) bool {
        return maxHeap[i][0] > maxHeap[j][0]
    })

    var result []rune
    var prev [2]int

    for len(maxHeap) > 0 || prev[0] > 0 {
        if prev[0] > 0 {
            maxHeap = append(maxHeap, prev)
        }

        if len(maxHeap) == 0 {
            return ""
        }

        curr := maxHeap[0]
        maxHeap = maxHeap[1:]
        result = append(result, rune(curr[1]))
        curr[0]--
        prev = curr
    }

    return string(result)
}