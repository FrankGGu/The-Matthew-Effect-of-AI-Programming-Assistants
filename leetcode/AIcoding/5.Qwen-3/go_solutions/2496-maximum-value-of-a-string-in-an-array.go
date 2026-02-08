package main

func maximumValue(strs []string) int {
    max := 0
    for _, s := range strs {
        if len(s) > max {
            max = len(s)
        }
    }
    return max
}