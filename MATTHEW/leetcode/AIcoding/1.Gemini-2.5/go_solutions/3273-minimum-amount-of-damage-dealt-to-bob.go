type State struct {
	damage int64 // Total damage dealt so far
	// cooldowns is a bitmask where each attack