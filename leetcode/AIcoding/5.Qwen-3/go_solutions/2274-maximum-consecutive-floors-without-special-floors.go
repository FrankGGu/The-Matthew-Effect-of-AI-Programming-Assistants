package main

func maxConsecutive(n int, special []int) int {
    sort.Ints(special)
    max := 0
    prev := 0
    for _, s := range special {
        max = maxInt(max, s-prev-1)
        prev = s
    }
    max = maxInt(max, n-prev)
    return max
}

func maxInt(a, b int) int {
    if a > b {
        return a
    }
    return b
}