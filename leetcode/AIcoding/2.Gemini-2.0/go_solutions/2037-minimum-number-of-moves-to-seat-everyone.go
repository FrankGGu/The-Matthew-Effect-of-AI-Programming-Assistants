import "sort"

func minMovesToSeat(seats []int, students []int) int {
    sort.Ints(seats)
    sort.Ints(students)
    moves := 0
    for i := 0; i < len(seats); i++ {
        moves += abs(seats[i] - students[i])
    }
    return moves
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}