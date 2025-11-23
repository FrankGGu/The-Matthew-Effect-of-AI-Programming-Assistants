package main

func isLongPressedName(name string, typed string) bool {
    i, j := 0, 0
    for i < len(name) && j < len(typed) {
        if name[i] != typed[j] {
            return false
        }
        cnt1, cnt2 := 0, 0
        c := name[i]
        for i < len(name) && name[i] == c {
            i++
            cnt1++
        }
        for j < len(typed) && typed[j] == c {
            j++
            cnt2++
        }
        if cnt2 < cnt1 {
            return false
        }
    }
    return i == len(name) && j == len(typed)
}