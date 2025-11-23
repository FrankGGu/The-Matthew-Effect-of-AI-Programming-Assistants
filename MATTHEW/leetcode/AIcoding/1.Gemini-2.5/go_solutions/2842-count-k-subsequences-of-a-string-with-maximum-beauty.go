const MOD int = 1e9 + 7

var fact [2001]int
var invFact [2001]int

func init() {
	fact[0] = 1
	invFact[0] = 1
	for i :=