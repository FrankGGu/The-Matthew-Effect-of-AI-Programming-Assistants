import "strings"

type Bitset struct {
	bits        []byte // 0 for unfixed, 1 for fixed (in the unflipped state)
	size        int
	fixedCount  int    // Number of '1's in the current logical state
	isFlipped   bool   // If true, 0s are