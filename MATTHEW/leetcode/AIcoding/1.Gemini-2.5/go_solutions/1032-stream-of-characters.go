type TrieNode struct {
	children map[byte]*TrieNode
	isEndOfWord bool
}

type StreamChecker struct {
	root *TrieNode
	stream []byte // Circular buffer for the last maxWordLength characters
	head int      // Index of the oldest character in the circular buffer
	tail int      // Index of the next available slot for a new character
	count int    // Number of characters currently in the stream
	maxWordLength int // Maximum length of any word in the dictionary
}

func (t *TrieNode) insert(word string) {
	curr := t
	for i := len(word) - 1; i >= 0; i-- { // Insert words in reverse
		char := word[i]
		if curr.children == nil {
			curr.children = make(map[byte]*TrieNode)
		}
		if curr.children[char] == nil {
			curr.children[char] = &TrieNode{}
		}
		curr = curr.children[char]
	}
	curr.isEndOfWord = true
}

func Constructor(words []string) StreamChecker {
	root := &TrieNode{}
	maxLen := 0
	for _, word := range words {
		root.insert(word)
		if len(word) > maxLen {
			maxLen = len(word)
		}
	}

	// If maxLen is 0 (empty words list), we can't create a buffer of size 0 and use it.
	// Handle this by setting maxWordLength to 1 if it's 0, or just let Query handle it.
	// For the problem constraints, words[i].length >= 1, so maxLen will be at least 1.
	// However, if words itself is empty, maxLen would be 0.
	// The problem states 1 <= words.length <= 2000, so maxLen will always be >= 1.

	return StreamChecker{
		root: root,
		stream: make([]byte, maxLen), // Fixed size buffer for circular queue
		head: 0,
		tail: 0,
		count: 0,
		maxWordLength: maxLen,
	}
}

func (this *StreamChecker) Query(char byte) bool {
	// Add char to circular buffer
	// If maxWordLength is 0 (e.g., words list was empty), then stream is empty
	// and we should not attempt to write to stream[0].
	// Problem constraints guarantee maxWordLength >= 1.
	this.stream[this.tail] = char
	this.tail = (this.tail + 1) % this.maxWordLength

	if this.count < this.maxWordLength {
		this.count++
	} else {
		// Buffer is full, so head advances to overwrite the oldest character
		this.head = (this.head + 1) % this.maxWordLength
	}

	// Check for suffix matches by traversing the Trie backwards from the newest character
	curr := this.root

	for k := 0; k < this.count; k++ {
		// Calculate the index for the k-th character from the end
		// (tail - 1 - k + maxWordLength) ensures positive index for modulo
		idx := (this.tail - 1 - k + this.maxWordLength) % this.maxWordLength
		c := this.stream[idx]

		if curr.children == nil || curr.children[c] == nil {
			return false // No path found for this suffix
		}
		curr = curr.children[c]
		if curr.isEndOfWord {
			return true // Found a word
		}
	}

	return false
}