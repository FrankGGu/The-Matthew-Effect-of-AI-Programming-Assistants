type ATM struct {
    denominations []int
    counts        []int64 // Use int64 for counts to handle large numbers of notes
}

func Constructor() ATM {
    return ATM{
        denominations: []int{20, 50, 100, 200, 50