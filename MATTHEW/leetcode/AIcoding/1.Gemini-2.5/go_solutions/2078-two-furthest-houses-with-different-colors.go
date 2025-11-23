package main

func twoFurthestHousesWithDifferentColors(colors []int) int {
    n := len(colors)
    ans := 0

    for j := n - 1; j >= 0; j-- {
        if colors[j] != colors[0] {
            ans = j 
            break
        }
    }

    for i := 0; i < n; i++ {
        if colors[i] != colors[n-1] {
            if (n - 1) - i > ans {
                ans = (n - 1) - i
            }
            break
        }
    }

    return ans
}