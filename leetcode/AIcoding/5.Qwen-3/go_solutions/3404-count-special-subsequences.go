package main

func countSpecialSubsequences(s string) int {
    var a, ab, abc int
    for _, c := range s {
        if c == 'a' {
            a = (a + 1) % (1000000007)
        } else if c == 'b' {
            ab = (ab + a) % (1000000007)
        } else if c == 'c' {
            abc = (abc + ab) % (1000000007)
        }
    }
    return abc
}