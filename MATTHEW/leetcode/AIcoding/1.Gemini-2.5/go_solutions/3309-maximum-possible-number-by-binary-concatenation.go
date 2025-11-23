const MOD int = 1e9 + 7

func concatenatedBinary(n int) int {
	result := 0
	length := 0 // length of the binary representation of the current number i
	nextPowerOf2 := 1 // tracks when the length needs to increment (e.g., 1, 2,