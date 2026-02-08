package main

func prisonAfterNDays(cells []int, n int) []int {
    seen := make(map[string]int)
    for n > 0 {
        nextDay := make([]int, len(cells))
        for i := 1; i < len(cells)-1; i++ {
            if cells[i-1] == cells[i+1] {
                nextDay[i] = 1
            } else {
                nextDay[i] = 0
            }
        }
        key := toString(nextDay)
        if val, ok := seen[key]; ok {
            n %= val
        } else {
            seen[key] = n
        }
        if n == 0 {
            break
        }
        cells = nextDay
        n--
    }
    return cells
}

func toString(cells []int) string {
    s := ""
    for _, v := range cells {
        s += strconv.Itoa(v)
    }
    return s
}