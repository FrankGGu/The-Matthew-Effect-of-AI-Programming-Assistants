package main

func movesToStamp(s string, t string) []int {
    n := len(s)
    m := len(t)
    target := []byte(t)
    source := []byte(s)
    visited := make([]bool, m)
    res := []int{}
    changed := true

    for changed {
        changed = false
        for i := 0; i <= m-n; i++ {
            if !visited[i] {
                match := true
                for j := 0; j < n; j++ {
                    if target[i+j] != source[j] {
                        match = false
                        break
                    }
                }
                if match {
                    changed = true
                    visited[i] = true
                    res = append(res, i)
                    for j := 0; j < n; j++ {
                        visited[i+j] = true
                    }
                }
            }
        }
    }

    for _, v := range visited {
        if !v {
            return []int{}
        }
    }

    for i := 0; i < len(res)/2; i++ {
        res[i], res[len(res)-1-i] = res[len(res)-1-i], res[i]
    }

    return res
}