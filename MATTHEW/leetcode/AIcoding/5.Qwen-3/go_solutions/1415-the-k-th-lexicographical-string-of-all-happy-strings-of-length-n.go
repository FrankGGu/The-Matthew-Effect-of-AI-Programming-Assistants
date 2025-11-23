package main

func getHappyString(n int, k int) string {
    var result []byte
    var count int

    var backtrack func(path []byte)
    backtrack = func(path []byte) {
        if len(path) == n {
            count++
            if count == k {
                result = append(result, path...)
            }
            return
        }

        for c := 'a'; c <= 'c'; c++ {
            if len(path) > 0 && path[len(path)-1] == byte(c) {
                continue
            }
            path = append(path, byte(c))
            backtrack(path)
            path = path[:len(path)-1]
            if count == k {
                return
            }
        }
    }

    backtrack([]byte{})
    return string(result)
}