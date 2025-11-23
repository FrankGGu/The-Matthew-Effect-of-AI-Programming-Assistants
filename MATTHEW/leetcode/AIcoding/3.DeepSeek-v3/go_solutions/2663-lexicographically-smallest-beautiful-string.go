func smallestBeautifulString(s string, k int) string {
    n := len(s)
    arr := make([]byte, n)
    for i := 0; i < n; i++ {
        arr[i] = s[i]
    }

    i := n - 1
    for i >= 0 {
        arr[i]++
        if arr[i] >= 'a'+byte(k) {
            i--
            continue
        }
        if (i >= 1 && arr[i] == arr[i-1]) || (i >= 2 && arr[i] == arr[i-2]) {
            continue
        }
        break
    }
    if i < 0 {
        return ""
    }

    for j := i + 1; j < n; j++ {
        for c := byte('a'); c < 'a'+byte(k); c++ {
            if (j >= 1 && c == arr[j-1]) || (j >= 2 && c == arr[j-2]) {
                continue
            }
            arr[j] = c
            break
        }
    }

    return string(arr)
}