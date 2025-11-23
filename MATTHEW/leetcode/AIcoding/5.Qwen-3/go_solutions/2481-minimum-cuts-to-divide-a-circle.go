package main

func numberOfCuts(neededTime string) int {
    if len(neededTime) == 1 {
        return 0
    }
    res := 0
    for i := 1; i < len(neededTime); i++ {
        if neededTime[i] != neededTime[i-1] {
            res++
        }
    }
    return res
}