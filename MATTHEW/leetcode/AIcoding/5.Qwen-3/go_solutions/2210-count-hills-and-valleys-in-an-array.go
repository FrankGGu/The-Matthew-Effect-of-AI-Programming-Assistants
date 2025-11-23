package main

func countHillsAndValleys(s []int) int {
    count := 0
    for i := 1; i < len(s)-1; i++ {
        if s[i] > s[i-1] && s[i] > s[i+1] || s[i] < s[i-1] && s[i] < s[i+1] {
            count++
        }
    }
    return count
}