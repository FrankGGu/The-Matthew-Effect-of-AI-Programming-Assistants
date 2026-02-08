package main

func buddyStrings(A string, B string) bool {
    if len(A) != len(B) {
        return false
    }
    if A == B {
        seen := make(map[rune]bool)
        for _, ch := range A {
            if seen[ch] {
                return true
            }
            seen[ch] = true
        }
        return false
    }
    var first, second int
    for i := 0; i < len(A); i++ {
        if A[i] != B[i] {
            if first == 0 {
                first = i
            } else if second == 0 {
                second = i
            } else {
                return false
            }
        }
    }
    return A[first] == B[second] && A[second] == B[first]
}