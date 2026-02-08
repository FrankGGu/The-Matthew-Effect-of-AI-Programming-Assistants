package main

func isTransformable(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }
    pos := make([][]int, 10)
    for i := range s {
        pos[int(s[i]-'0')] = append(pos[int(s[i]-'0')], i)
    }
    for i := range t {
        num := int(t[i] - '0')
        if len(pos[num]) == 0 {
            return false
        }
        for j := 0; j < num; j++ {
            if len(pos[j]) > 0 && pos[j][0] < pos[num][0] {
                return false
            }
        }
        pos[num] = pos[num][1:]
    }
    return true
}