func init() {
	rand.Seed(time.Now().UnixNano()) // Initialize random seed for pivot selection
}

func findKthLargest(nums []int, k int) int {
	n := len(nums)
	// The k