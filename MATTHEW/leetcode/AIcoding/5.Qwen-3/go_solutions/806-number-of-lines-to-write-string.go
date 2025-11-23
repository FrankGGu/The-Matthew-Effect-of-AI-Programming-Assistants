package main

func numberOfLines(nums []int, s string) []int {
    lines := 1
    width := 0
    for _, c := range s {
        w := nums[c-'a']
        if width + w > 100 {
            lines++
            width = w
        } else {
            width += w
        }
    }
    return []int{lines, width}
}