import (
	"strings"
)

type TrieNode struct {
	children map[rune]*TrieNode
	isEndOfWord bool
}

func newTrieNode() *TrieNode {
	return &TrieNode{
		children: make(map[rune]*TrieNode),
	}
}

type Trie struct {
	root *TrieNode
}

func newTrie() *Trie {
	return &Trie{
		root: newTrieNode(),
	}
}

func (t *Trie) Insert(word string) {
	curr := t.root
	for _, char := range word {
		if _, ok := curr.children[char]; !ok {
			curr.children[char] = newTrieNode()
		}
		curr = curr.children[char]
	}
	curr.isEndOfWord = true
}

func (t *Trie) FindShortestRoot(word string) string {
	curr := t.root
	for i, char := range word {
		if curr.isEndOfWord {
			return word[:i]
		}
		if _, ok := curr.children[char]; !ok {
			return word
		}
		curr = curr.children[char]
	}
	if curr.isEndOfWord {
		return word
	}
	return word
}

func replaceWords(dictionary []string, sentence string) string {
	trie := newTrie()
	for _, root := range dictionary {
		trie.Insert(root)
	}

	words := strings.Fields(sentence)
	replacedWords := make([]string, len(words))

	for i, word := range words {
		replacedWords[i] = trie.FindShortestRoot(word)
	}

	return strings.Join(replacedWords, " ")
}