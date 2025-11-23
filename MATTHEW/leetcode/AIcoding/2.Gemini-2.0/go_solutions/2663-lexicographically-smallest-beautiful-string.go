func smallestBeautifulString(s string, k int) string {
	n := len(s)
	bytes := []byte(s)

	for i := n - 1; i >= 0; i-- {
		for j := bytes[i] + 1; byte(j) < byte('a'+k); j++ {
			valid := true
			if i > 0 && j == bytes[i-1] {
				valid = false
			}
			if i > 1 && j == bytes[i-2] {
				valid = false
			}

			if valid {
				bytes[i] = j
				for l := i + 1; l < n; l++ {
					for m := byte('a'); byte(m) < byte('a'+k); m++ {
						valid2 := true
						if l > 0 && m == bytes[l-1] {
							valid2 = false
						}
						if l > 1 && m == bytes[l-2] {
							valid2 = false
						}

						if valid2 {
							bytes[l] = m
							break
						}
					}
				}
				return string(bytes)
			}
		}
	}

	return ""
}