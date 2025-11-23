package main

func isSumEqual(s1 string, s2 string, target string) bool {
    sum1 := 0
    sum2 := 0
    for _, c := range s1 {
        sum1 = sum1*10 + int(c-'a')
    }
    for _, c := range s2 {
        sum2 = sum2*10 + int(c-'a')
    }
    targetSum := 0
    for _, c := range target {
        targetSum = targetSum*10 + int(c-'a')
    }
    return sum1 + sum2 == targetSum
}