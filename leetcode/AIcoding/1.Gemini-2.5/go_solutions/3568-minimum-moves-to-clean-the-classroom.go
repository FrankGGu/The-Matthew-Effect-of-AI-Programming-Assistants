type Cell struct {
	r, c int
}

type State struct {
	r, c        int
	kRemaining  int
	cleanedMask int
	moves       int
}

type