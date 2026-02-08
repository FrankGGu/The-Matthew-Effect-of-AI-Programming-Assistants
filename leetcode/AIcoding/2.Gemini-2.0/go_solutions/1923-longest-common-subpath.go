func longestCommonSubpath(n int, paths [][]int) int {
	l, r := 0, 100000
	for l < r {
		mid := (l + r + 1) / 2
		if check(paths, mid) {
			l = mid
		} else {
			r = mid - 1
		}
	}
	return l
}

func check(paths [][]int, length int) bool {
	if length == 0 {
		return true
	}
	prime1, prime2 := int64(1000000007), int64(1000000009)
	base := int64(257)
	seen := make(map[int64]bool)
	firstPath := paths[0]
	pow1, pow2 := int64(1), int64(1)
	for i := 1; i < length; i++ {
		pow1 = (pow1 * base) % prime1
		pow2 = (pow2 * base) % prime2
	}
	hash1, hash2 := int64(0), int64(0)
	for i := 0; i < length; i++ {
		hash1 = (hash1*base + int64(firstPath[i])) % prime1
		hash2 = (hash2*base + int64(firstPath[i])) % prime2
	}
	seen[hash1*prime2+hash2] = true
	for i := length; i < len(firstPath); i++ {
		hash1 = (hash1 - int64(firstPath[i-length])*pow1%prime1 + prime1) % prime1
		hash1 = (hash1*base + int64(firstPath[i])) % prime1
		hash2 = (hash2 - int64(firstPath[i-length])*pow2%prime2 + prime2) % prime2
		hash2 = (hash2*base + int64(firstPath[i])) % prime2
		seen[hash1*prime2+hash2] = true
	}
	for i := 1; i < len(paths); i++ {
		currentPath := paths[i]
		currentSeen := make(map[int64]bool)
		hash1, hash2 = int64(0), int64(0)
		for j := 0; j < length; j++ {
			hash1 = (hash1*base + int64(currentPath[j])) % prime1
			hash2 = (hash2*base + int64(currentPath[j])) % prime2
		}
		if seen[hash1*prime2+hash2] {
			currentSeen[hash1*prime2+hash2] = true
		}
		for j := length; j < len(currentPath); j++ {
			hash1 = (hash1 - int64(currentPath[j-length])*pow1%prime1 + prime1) % prime1
			hash1 = (hash1*base + int64(currentPath[j])) % prime1
			hash2 = (hash2 - int64(currentPath[j-length])*pow2%prime2 + prime2) % prime2
			hash2 = (hash2*base + int64(currentPath[j])) % prime2
			if seen[hash1*prime2+hash2] {
				currentSeen[hash1*prime2+hash2] = true
			}
		}
		seen = currentSeen
		if len(seen) == 0 {
			return false
		}
	}
	return true
}