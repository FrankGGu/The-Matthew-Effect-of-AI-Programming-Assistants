package main

func mostCommonResponse(statements []string) string {
    responseCount := make(map[string]int)
    maxCount := 0
    var mostCommon string

    for _, stmt := range statements {
        if stmt == "A" || stmt == "B" || stmt == "C" || stmt == "D" || stmt == "E" {
            responseCount[stmt]++
            if responseCount[stmt] > maxCount {
                maxCount = responseCount[stmt]
                mostCommon = stmt
            }
        }
    }

    return mostCommon
}