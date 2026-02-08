import "math"

func twoEggDrop(n int) int {
	// We are looking for the minimum number of moves 'x' such that we can
	// cover 'n' floors with 2 eggs.
	// Let f(x) be the maximum number of floors we can cover with 'x' moves and 2 eggs.
	// If the first egg is dropped at floor 'i':
	// 1. If it breaks: We have 1 egg and x-1 moves left. We need to test floors 1 to i-1.
	//    With 1 egg and x-1 moves, we can test at most x-1 floors. So i-1 <= x-1, meaning i <= x.
	// 2. If it doesn't break: We have 2 eggs and x-1 moves left. We need to test floors i+1 to N.
	//    The number of additional floors we can test is f(x-1).
	// To minimize total moves in the worst case, we choose 'i' such that the number of floors
	// covered in either scenario is maximized.
	// The maximum number of floors we can cover with 'x' moves is:
	// f(x) = (floors covered if first egg breaks) + (floors covered if first egg doesn't break) + 1 (for the current drop)
	// f(x) = (x-1) + f(x-1) + 1
	// f(x) = f(x-1) + x
	// With base case f(0) = 0.
	// So, f(x) = 1 + 2 + ... + x = x * (x + 1) / 2.
	// We need to find the smallest integer 'x' such that x * (x + 1) / 2 >= n.

	// Iterative approach:
	drops := 0
	floorsCovered := 0
	for {
		drops++
		floorsCovered += drops
		if floorsCovered >= n {
			return drops
		}
	}

	// Alternative: Mathematical approach by solving the quadratic equation x*(x+1)/2 >= n
	// x^2 + x - 2n >= 0
	// Using quadratic formula: x = (-1 + sqrt(1 - 4*1*(-2n))) / 2
	// x = (-1 + sqrt(1 + 8n)) / 2
	// Since x must be an integer, we take the ceiling of this value.
	// return int(math.Ceil((-1 + math.Sqrt(1+float64(8*n))) / 2))
}