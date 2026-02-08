func findRelativeRanks(score []int) []string {
    n := len(score)
    ranks := make([]string, n)
    sortedScores := make([]int, n)
    copy(sortedScores, score)
    sort.Sort(sort.Reverse(sort.IntSlice(sortedScores)))

    for i, s := range sortedScores {
        for j, original := range score {
            if s == original {
                switch i {
                case 0:
                    ranks[j] = "Gold Medal"
                case 1:
                    ranks[j] = "Silver Medal"
                case 2:
                    ranks[j] = "Bronze Medal"
                default:
                    ranks[j] = strconv.Itoa(i + 1)
                }
                break
            }
        }
    }

    return ranks
}