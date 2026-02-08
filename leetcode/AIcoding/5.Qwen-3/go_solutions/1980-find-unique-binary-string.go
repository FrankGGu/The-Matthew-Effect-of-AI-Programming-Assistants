package main

func findDifferentBinaryString(nums []string) string {
    n := len(nums)
    seen := make(map[string]bool)
    for _, num := range nums {
        seen[num] = true
    }
    for i := 0; i < 1<<n; i++ {
        bin := ""
        for j := 0; j < n; j++ {
            if i&(1<<j) != 0 {
                bin = "1" + bin
            } else {
                bin = "0" + bin
            }
        }
        if !seen[bin] {
            return bin
        }
    }
    return ""
}