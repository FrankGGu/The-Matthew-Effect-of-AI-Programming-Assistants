package main

func longestDupSubstring(s string) string {
	n := len(s)
	if n == 0 {
		return ""
	}

	var ansStart int = -1
	var ansLen int = 0

	p1 := uint64(31)
	p2 := uint64(131)
	m1 := uint64(1_000_000_007)
	m2 := uint64(1_000_000_009)

	p1_pow := make([]uint64, n+1)
	p2_pow := make([]uint64, n+1)
	p1_pow[0] = 1
	p2_pow[0] = 1
	for i := 1; i <= n; i++ {
		p1_pow[i] = (p1_pow[i-1] * p1) % m1
		p2_pow[i] = (p2_pow[i-1] * p2) % m2
	}

	checkTwoHashes := func(length int) (int, bool) {
		if length == 0 {
			return -1, false
		}
		if length > n {
			return -1, false
		}

		h1 := uint64(0)
		h2 := uint64(0)
		for i := 0; i < length; i++ {
			val := uint64(s[i] - 'a' + 1)
			h1 = (h1*p1 + val) % m1
			h2 = (h2*p2 + val) % m2
		}

		type hashPair struct {
			h1 uint64
			h2 uint64
		}
		hashes := make(map[hashPair][]int)
		hashes[hashPair{h1, h2}] = append(hashes[hashPair{h1, h2}], 0)

		for i := 1; i <= n-length; i++ {
			val_prev := uint64(s[i-1] - 'a' + 1)
			val_curr := uint64(s[i+length-1] - 'a' + 1)

			h1 = (h1 - (val_prev*p1_pow[length-1])%m1 + m1) % m1
			h1 = (h1*p1 + val_curr) % m1

			h2 = (h2 - (val_prev*p2_pow[length-1])%m2 + m2) % m2
			h2 = (h2*p2 + val_curr) % m2

			currentHashPair := hashPair{h1, h2}
			if indices, ok := hashes[currentHashPair]; ok {
				return indices[0], true
			}
			hashes[currentHashPair] = append(hashes[currentHashPair], i)
		}

		return -1, false
	}

	low := 1
	high := n - 1

	for low <= high {
		mid := low + (high-low)/2
		foundIdx, found := checkTwoHashes(mid)
		if found {
			ansLen = mid
			ansStart = foundIdx
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	if ansStart == -1 {
		return ""
	}
	return s[ansStart : ansStart+ansLen]
}