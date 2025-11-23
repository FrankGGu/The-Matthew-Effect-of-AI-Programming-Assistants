package main

func findCrossingTime(n int, k int, time []int) int {
    type pair struct {
        i, t int
    }
    var (
        in  = make([]bool, k)
        out = make([]bool, k)
        up  = make([]bool, k)
        down = make([]bool, k)
        q   = make([][]int, 2)
        res int
        cnt = 0
        t   int
    )
    for i := 0; i < k; i++ {
        q[0] = append(q[0], i)
    }
    for cnt < n {
        for i := 0; i < 2; i++ {
            for len(q[i]) > 0 {
                j := q[i][0]
                q[i] = q[i][1:]
                if i == 0 {
                    if !in[j] && !out[j] {
                        in[j] = true
                        t += time[j]
                    }
                } else {
                    if !out[j] && !in[j] {
                        out[j] = true
                        t += time[j]
                    }
                }
                if i == 0 {
                    if in[j] {
                        in[j] = false
                        up[j] = true
                    }
                } else {
                    if out[j] {
                        out[j] = false
                        down[j] = true
                    }
                }
            }
        }
        for i := 0; i < k; i++ {
            if up[i] && in[i] {
                up[i] = false
                in[i] = true
                q[0] = append(q[0], i)
            }
            if down[i] && out[i] {
                down[i] = false
                out[i] = true
                q[1] = append(q[1], i)
            }
        }
        for i := 0; i < k; i++ {
            if in[i] && t >= time[i] {
                in[i] = false
                cnt++
            }
            if out[i] && t >= time[i] {
                out[i] = false
                cnt++
            }
        }
        t++
    }
    return res
}