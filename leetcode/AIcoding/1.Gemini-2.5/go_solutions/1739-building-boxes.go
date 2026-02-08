import "math"

func minimumBoxes(n int) int {
	// Find the largest k such that k*(k+1)*(k+2)/6 <= n
	// This k represents the number of layers in a full pyramid structure
	// floor_k is the number of boxes on the floor for this full pyramid
	//