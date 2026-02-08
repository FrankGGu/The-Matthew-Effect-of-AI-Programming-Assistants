package main

func partitionString(s string, k int) int {
    count := 1
    current := 0
    for _, c := range s {
        num := int(c - 'a' + 1)
        if current*26+num > k {
            count++
            current = num
        } else {
            current = current*26 + num
        }
    }
    return count
}