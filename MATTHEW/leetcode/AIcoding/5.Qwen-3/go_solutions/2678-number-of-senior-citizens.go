package main

func numSeniorCitizens(details []string) int {
    count := 0
    for _, d := range details {
        if len(d) >= 11 && d[10] >= '6' {
            count++
        }
    }
    return count
}