package main

func nameMe(students []string, target string) int {
    for i, name := range students {
        if name == target {
            return i
        }
    }
    return -1
}