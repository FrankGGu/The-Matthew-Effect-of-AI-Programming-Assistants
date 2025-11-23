package main

func interchangeableRectangles(rectangles [][]int) int64 {
    ratioMap := make(map[string]int)
    for _, rect := range rectangles {
        a, b := rect[0], rect[1]
        gcd := func(x, y int) int {
            for y != 0 {
                x, y = y, x%y
            }
            return x
        }(a, b)
        key := fmt.Sprintf("%d/%d", a/gcd, b/gcd)
        ratioMap[key]++
    }

    var result int64
    for _, count := range ratioMap {
        if count >= 2 {
            result += int64(count * (count - 1) / 2)
        }
    }
    return result
}