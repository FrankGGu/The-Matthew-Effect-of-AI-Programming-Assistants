package main

func fullBloomFlowers(flowers [][]int, people []int) []int {
    start := make([]int, 0, len(flowers))
    end := make([]int, 0, len(flowers))
    for _, f := range flowers {
        start = append(start, f[0])
        end = append(end, f[1])
    }
    sort.Ints(start)
    sort.Ints(end)
    res := make([]int, len(people))
    for i, t := range people {
        s := sort.SearchInts(start, t)
        e := sort.SearchInts(end, t)
        res[i] = s - e
    }
    return res
}