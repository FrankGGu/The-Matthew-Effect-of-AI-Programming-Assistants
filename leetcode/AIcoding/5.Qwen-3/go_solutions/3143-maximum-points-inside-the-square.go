package main

func maxPointsInsideSquare(points [][]int, s string) int {
    type point struct {
        x, y int
    }
    n := len(points)
    m := len(s)
    if n != m {
        return 0
    }
    for i := 0; i < n; i++ {
        if points[i][0] == points[i][1] {
            return 0
        }
    }
    var res int
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if (points[i][0] == points[j][0] || points[i][1] == points[j][1]) && s[i] == s[j] {
                return 0
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i != j && (points[i][0] == points[j][0] || points[i][1] == points[j][1]) && s[i] == s[j] {
                return 0
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                if s[i] == s[j] {
                    return 0
                }
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                if s[i] == s[j] {
                    return 0
                }
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                if s[i] == s[j] {
                    return 0
                }
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                if s[i] == s[j] {
                    return 0
                }
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                if s[i] == s[j] {
                    return 0
                }
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                if s[i] == s[j] {
                    return 0
                }
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                if s[i] == s[j] {
                    return 0
                }
            }
        }
    }
......