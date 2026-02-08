package main

func customSortString(x string, y string) string {
    count := make(map[rune]int)
    for _, c := range y {
        count[c]++
    }
    res := make([]rune, 0, len(y))
    for _, c := range x {
        for count[c] > 0 {
            res = append(res, c)
            count[c]--
        }
    }
    for c, cnt := range count {
        for cnt > 0 {
            res = append(res, c)
            cnt--
        }
    }
    return string(res)
}