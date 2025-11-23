package main

func countGoodStrings(s1 string, s2 string, minSizeS1 int, minSizeS2 int) int {
    set := make(map[string]bool)
    for i := 0; i <= len(s1)-minSizeS1; i++ {
        substr := s1[i : i+minSizeS1]
        set[substr] = true
    }
    count := 0
    for i := 0; i <= len(s2)-minSizeS2; i++ {
        substr := s2[i : i+minSizeS2]
        if set[substr] {
            count++
        }
    }
    return count
}