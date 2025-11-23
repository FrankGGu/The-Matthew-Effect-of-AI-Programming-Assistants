package main

func numberOfAlternatingGroups(colors []int) int {
    n := len(colors)
    count := 0
    for i := 0; i < n; i++ {
        a, b, c := colors[i], colors[(i+1)%n], colors[(i+2)%n]
        if a != b && b != c {
            count++
        }
    }
    return count
}