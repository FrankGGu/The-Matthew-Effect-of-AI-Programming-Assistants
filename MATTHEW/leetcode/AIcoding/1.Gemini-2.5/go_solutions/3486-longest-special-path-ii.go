type State struct {
	r, c        int
	dir         int // 0: up, 1: right, 2: down, 3: left
	straightLen int // length of current straight path in this direction
	cost