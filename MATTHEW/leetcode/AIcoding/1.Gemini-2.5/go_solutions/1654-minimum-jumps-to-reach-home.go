import "container/list"

func minimumJumps(forbidden []int, a int, b int, x int) int {
	// State: {position, previous_was_backward_jump, steps}
	type State struct {
		pos              int
		prevWasBackward  bool
		steps            int
	}

	// Max position