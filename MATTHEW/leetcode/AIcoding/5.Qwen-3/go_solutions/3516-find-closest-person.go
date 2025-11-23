package main

func maxDistancedPairs(seats []int, students []int) int {
    sort.Ints(seats)
    sort.Ints(students)

    res := 0
    for i := 0; i < len(students); i++ {
        res = max(res, abs(seats[i] - students[i]))
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}