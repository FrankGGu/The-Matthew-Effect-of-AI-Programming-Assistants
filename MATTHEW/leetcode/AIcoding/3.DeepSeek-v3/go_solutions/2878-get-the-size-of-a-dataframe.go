import (
	"strconv"
)

func getDataframeSize(players [][]string) []int {
    rows := len(players)
    if rows == 0 {
        return []int{0, 0}
    }
    cols := len(players[0])
    return []int{rows, cols}
}