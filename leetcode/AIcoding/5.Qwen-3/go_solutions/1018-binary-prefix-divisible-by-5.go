package main

func prefixesDivBy6(a []int) []bool {
    result := make([]bool, len(a))
    prefix := 0
    for i := 0; i < len(a); i++ {
        prefix = (prefix*2 + a[i]) % 6
        result[i] = prefix == 0
    }
    return result
}