package main

func digitSum(s string) int {
    sum := 0
    for _, c := range s {
        sum += int(c - '0')
    }
    return sum
}

func smallestIndex(s string) int {
    for i := 0; i < len(s); i++ {
        if digitSum(s[:i+1]) == i {
            return i
        }
    }
    return -1
}