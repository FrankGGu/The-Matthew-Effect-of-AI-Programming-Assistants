var C [][]int64 // combinations table
var memo map[string]int64
var K int // Number of distinct colors
var N_half int // Half of the total number of balls
var B []int // balls array from input

func initCombinations(maxN int