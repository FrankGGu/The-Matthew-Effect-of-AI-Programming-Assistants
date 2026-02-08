package main

func minChanges(stringA string, stringB string) int {
    countA := make([]int, 26)
    countB := make([]int, 26)
    for _, c := range stringA {
        countA[c-'a']++
    }
    for _, c := range stringB {
        countB[c-'a']++
    }

    var changes int
    for i := 0; i < 26; i++ {
        if countA[i] > countB[i] {
            changes += countA[i] - countB[i]
        } else {
            changes += countB[i] - countA[i]
        }
    }
    return changes
}