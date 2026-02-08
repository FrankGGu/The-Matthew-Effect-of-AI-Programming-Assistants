const MOD = 1e9 + 7

var memo [501][2][51]int // n, tight, evil_match_len
var N int
var S string
var Evil string
var EvilLen int
var NextState [][]int

func kmpPre