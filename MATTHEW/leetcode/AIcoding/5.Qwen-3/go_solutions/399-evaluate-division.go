package main

func equationsPossible(nums []string) []int {
    parent := make(map[string]string)

    var find func(string) string
    find = func(x string) string {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    var union func(string, string)
    union = func(x, y string) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootX] = rootY
        }
    }

    for _, num := range nums {
        if num[0] == num[2] && num[1] == '!' {
            continue
        }
        a, b := num[0], num[2]
        if _, ok := parent[a]; !ok {
            parent[a] = a
        }
        if _, ok := parent[b]; !ok {
            parent[b] = b
        }
        if num[1] == '=' {
            union(a, b)
        }
    }

    res := make([]int, 0)
    for _, num := range nums {
        if num[0] == num[2] && num[1] == '!' {
            res = append(res, 0)
            continue
        }
        a, b := num[0], num[2]
        if _, ok := parent[a]; !ok {
            parent[a] = a
        }
        if _, ok := parent[b]; !ok {
            parent[b] = b
        }
        if num[1] == '=' {
            if find(a) == find(b) {
                res = append(res, 1)
            } else {
                res = append(res, 0)
            }
        } else {
            if find(a) != find(b) {
                res = append(res, 1)
            } else {
                res = append(res, 0)
            }
        }
    }
    return res
}