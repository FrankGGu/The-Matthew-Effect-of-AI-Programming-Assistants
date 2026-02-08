package main

func isPrefixString(nums []string, s string) bool {
    var current string
    for _, num := range nums {
        current += num
        if current == s {
            return true
        }
    }
    return false
}