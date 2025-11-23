func checkPalindrome(s string) bool {
	l, r := 0, len(s)-1
	for l < r {
		if s[l] != s[r] {
			return false
		}
		l++
		r--
	}
	return true
}

func check(a string, b string) bool {
	l, r := 0, len(a)-1
	for l < r {
		if a[l] != b[r] {
			break
		}
		l++
		r--
	}
	if l >= r {
		return true
	}
	return checkPalindrome(a[l:r+1]) || checkPalindrome(b[l:r+1])
}

func check2(a string, b string) bool {
    l, r := 0, len(a)-1
    for l < r {
        if a[l] != b[r] {
            break
        }
        l++
        r--
    }

    if l >= r {
        return true
    }

    return checkPalindrome(a[l:r+1]) || checkPalindrome(b[l:r+1])
}

func splitTwoStrings(a string, b string) bool {
	return check(a, b) || check(b, a)
}