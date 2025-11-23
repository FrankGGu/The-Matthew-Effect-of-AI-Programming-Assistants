package main

func minPartitions(n string) int {
    max := 0
    for _, c := range n {
        if int(c-'0') > max {
            max = int(c - '0')
        }
    }
    return max
}