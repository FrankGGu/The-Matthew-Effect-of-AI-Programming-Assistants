func shortestUncommonSubstring(arr []string) []string {
    n := len(arr)
    result := make([]string, n)

    for i := 0; i < n; i++ {
        s := arr[i]
        m := len(s)
        found := false

        for l := 1; l <= m && !found; l++ {
            for j := 0; j <= m-l; j++ {
                sub := s[j:j+l]
                uncommon := true

                for k := 0; k < n; k++ {
                    if k == i {
                        continue
                    }
                    if strings.Contains(arr[k], sub) {
                        uncommon = false
                        break
                    }
                }

                if uncommon {
                    result[i] = sub
                    found = true
                    break
                }
            }
        }

        if !found {
            result[i] = ""
        }
    }

    return result
}