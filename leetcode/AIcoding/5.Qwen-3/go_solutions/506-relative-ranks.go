package main

func findRelativeRanks(score []int) []string {
    sorted := make([]int, len(score))
    copy(sorted, score)
    sort.Ints(sorted)

    rankMap := make(map[int]string)
    for i := len(sorted) - 1; i >= 0; i-- {
        switch len(sorted) - i {
        case 1:
            rankMap[sorted[i]] = "Gold Medal"
        case 2:
            rankMap[sorted[i]] = "Silver Medal"
        case 3:
            rankMap[sorted[i]] = "Bronze Medal"
        default:
            rankMap[sorted[i]] = strconv.Itoa(len(sorted) - i)
        }
    }

    result := make([]string, len(score))
    for i := range score {
        result[i] = rankMap[score[i]]
    }

    return result
}