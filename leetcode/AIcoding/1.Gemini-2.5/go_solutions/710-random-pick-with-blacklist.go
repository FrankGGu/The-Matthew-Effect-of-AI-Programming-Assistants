type Solution struct {
	validCount int
	mapping    map[int]int
	r          *rand.Rand
}

func Constructor(n int, blacklist []int) Solution {
	// Initialize random source
	source := rand.NewSource(time.Now().