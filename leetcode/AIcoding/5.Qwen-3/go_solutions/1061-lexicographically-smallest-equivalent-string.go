package main

func smallestEquivalentString(s string, t string, original string) string {
    parent := make([]byte, 26)

    for i := 0; i < 26; i++ {
        parent[i] = byte(i)
    }

    var find func(byte) byte
    find = func(x byte) byte {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    var union func(byte, byte)
    union = func(x, y byte) {
        px := find(x)
        py := find(y)
        if px != py {
            parent[px] = py
        }
    }

    for i := 0; i < len(s); i++ {
        union(s[i]-'a', t[i]-'a')
    }

    result := make([]byte, len(original))
    for i := 0; i < len(original); i++ {
        result[i] = find(original[i]-'a') + 'a'
    }

    return string(result)
}