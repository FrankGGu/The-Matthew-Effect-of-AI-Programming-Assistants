package main

func pourWater(heights []int, V int, K int) []int {
    for V > 0 {
        poured := 0
        for i := K; i >= 0 && heights[i] > 0; i-- {
            if i == 0 || heights[i-1] < heights[i] {
                poured = 1
                heights[i]--
                break
            }
        }
        if poured == 0 {
            for i := K; i < len(heights) && heights[i] > 0; i++ {
                if i == len(heights)-1 || heights[i+1] < heights[i] {
                    poured = 1
                    heights[i]--
                    break
                }
            }
        }
        if poured == 0 {
            break
        }
        V--
    }
    return heights
}