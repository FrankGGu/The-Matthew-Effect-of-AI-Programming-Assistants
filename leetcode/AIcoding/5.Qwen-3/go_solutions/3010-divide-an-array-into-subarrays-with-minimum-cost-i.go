package main

func makeArrayConsecutive2(sequence []int) int {
    min := sequence[0]
    max := sequence[0]
    for _, num := range sequence {
        if num < min {
            min = num
        }
        if num > max {
            max = num
        }
    }
    needed := 0
    used := make(map[int]bool)
    for _, num := range sequence {
        used[num] = true
    }
    for i := min; i <= max; i++ {
        if !used[i] {
            needed++
        }
    }
    return needed
}