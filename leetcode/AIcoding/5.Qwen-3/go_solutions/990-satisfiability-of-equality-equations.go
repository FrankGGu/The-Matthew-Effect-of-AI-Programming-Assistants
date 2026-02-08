package main

func equationsPossible(nums []string) bool {
    parent := make([]int, 26)

    for i := 0; i < 26; i++ {
        parent[i] = i
    }

    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    for _, s := range nums {
        if s[1] == '=' {
            x := int(s[0] - 'a')
            y := int(s[3] - 'a')
            parent[find(x)] = find(y)
        }
    }

    for _, s := range nums {
        if s[1] == '!' {
            x := int(s[0] - 'a')
            y := int(s[3] - 'a')
            if find(x) == find(y) {
                return false
            }
        }
    }

    return true
}