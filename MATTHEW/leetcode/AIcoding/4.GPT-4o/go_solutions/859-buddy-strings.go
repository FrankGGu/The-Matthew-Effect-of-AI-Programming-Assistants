func buddyStrings(A string, B string) bool {
    if len(A) != len(B) {
        return false
    }
    if A == B {
        seen := make(map[rune]bool)
        for _, c := range A {
            if seen[c] {
                return true
            }
            seen[c] = true
        }
        return false
    }

    diff := []int{}
    for i := 0; i < len(A); i++ {
        if A[i] != B[i] {
            diff = append(diff, i)
        }
    }

    return len(diff) == 2 && A[diff[0]] == B[diff[1]] && A[diff[1]] == B[diff[0]]
}