type TrieNode struct {
	children [2]*TrieNode // children[0] for bit '0', children[1] for bit '1'
}

const maxBits = 30 // Numbers are non-negative and less than 2^31, so bits range from 0 to 30.

func (t *TrieNode) insert(num int) {
	curr := t
	for i := maxBits; i >= 0; i-- {
		bit := (num >> i) & 1 // Get the i-th bit
		if curr.children[bit] == nil {
			curr.children[bit] = &TrieNode{}
		}
		curr = curr.children[bit]
	}
}

func (t *TrieNode) findMaxXOR(num int) int {
	curr := t
	maxXOR := 0
	for i := maxBits; i >= 0; i-- {
		bit := (num >> i) & 1
		// We want to find a number in the Trie whose i-th bit is opposite to `bit`
		// to maximize the XOR sum at this position.
		desiredBit := 1 - bit

		if curr.children[desiredBit] != nil {
			// If the opposite bit path exists, take it. This contributes '1' to the current bit of maxXOR.
			maxXOR |= (1 << i) // Set the i-th bit of maxXOR to 1
			curr = curr.children[desiredBit]
		} else {
			// If the opposite bit path does not exist, we must take the same bit path.
			// This contributes '0' to the current bit of maxXOR.
			// No need to explicitly set 0 as maxXOR is initialized to 0.
			curr = curr.children[bit]