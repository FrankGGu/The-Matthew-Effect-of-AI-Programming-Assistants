package main

func leastInterval(tasks []byte, n int) int {
    count := make(map[byte]int)
    for _, task := range tasks {
        count[task]++
    }

    maxFreq := 0
    for _, v := range count {
        if v > maxFreq {
            maxFreq = v
        }
    }

    numMaxFreq := 0
    for _, v := range count {
        if v == maxFreq {
            numMaxFreq++
        }
    }

    return max((maxFreq-1)*(n+1)+numMaxFreq, len(tasks))
}