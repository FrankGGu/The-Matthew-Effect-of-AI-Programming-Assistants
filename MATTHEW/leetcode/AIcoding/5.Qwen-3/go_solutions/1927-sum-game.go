package main

func isSumEqual(target string, arr []string) bool {
    targetSum := 0
    for _, c := range target {
        targetSum += int(c)
    }
    for _, s := range arr {
        sum := 0
        for _, c := range s {
            sum += int(c)
        }
        if sum == targetSum {
            return true
        }
    }
    return false
}