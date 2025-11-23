import "container/list"

func minJumps(arr []int) int {
	n := len(arr)
	if n <= 1 {
		return 0
	}

	// Step 1: Preprocess the array to group indices by their values.
	// This map stores value -> list of indices where that