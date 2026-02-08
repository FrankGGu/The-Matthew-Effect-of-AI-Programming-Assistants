import "sort"

func matchPlayersAndTrainers(players []int, trainers []int) int {
    sort.Ints(players)
    sort.Ints(trainers)

    res := 0
    i, j := 0, 0
    for i < len(players) && j < len(trainers) {
        if players[i] <= trainers[j] {
            res++
            i++
            j++
        } else {
            j++
        }
    }
    return res
}