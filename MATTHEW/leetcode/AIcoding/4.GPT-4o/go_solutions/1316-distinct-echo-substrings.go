package main

import (
	"fmt"
	"hash/maphash"
)

func distinctEchoSubstrings(text string) int {
	n := len(text)
	hashes := make(map[uint64]struct{})
	mh := maphash.Hash{}
	for length := 1; length <= n/2; length++ {
		mh.Reset()
		seen := make(map[uint64]struct{})
		for i := 0; i <= n-length; i++ {
			if i+2*length <= n {
				mh.WriteString(text[i : i+length])
				hash1 := mh.Sum64()
				mh.Reset()
				mh.WriteString(text[i+length : i+2*length])
				hash2 := mh.Sum64()
				if hash1 == hash2 {
					seen[hash1] = struct{}{}
				}
			}
		}
		for k := range seen {
			hashes[k] = struct{}{}
		}
	}
	return len(hashes)
}

func main() {
	fmt.Println(distinctEchoSubstrings("abcabcabc")) // Example usage
}