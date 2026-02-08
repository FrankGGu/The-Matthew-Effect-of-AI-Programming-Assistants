package main

func minAreaII(pixels []string) int {
    if len(pixels) == 0 || len(pixels[0]) == 0 {
        return 0
    }
    rows, cols := len(pixels), len(pixels[0])
    var top, bottom, left, right int = rows, -1, cols, -1

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if pixels[i][j] == '1' {
                if i < top {
                    top = i
                }
                if i > bottom {
                    bottom = i
                }
                if j < left {
                    left = j
                }
                if j > right {
                    right = j
                }
            }
        }
    }

    if top > bottom || left > right {
        return 0
    }

    return (bottom - top + 1) * (right - left + 1)
}