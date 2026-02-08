package main

func pyramidTransitionMatrix(tiles string, target string) bool {
    from := make(map[byte][]byte)
    for i := 0; i < len(tiles); i += 2 {
        from[tiles[i]] = append(from[tiles[i]], tiles[i+1])
    }

    var dfs func([]byte, int) bool
    dfs = func(current []byte, pos int) bool {
        if pos == len(target) {
            return true
        }
        if len(current) < pos+1 {
            return false
        }
        key := current[pos]
        for _, next := range from[key] {
            current[pos+1] = next
            if dfs(current, pos+1) {
                return true
            }
        }
        return false
    }

    return dfs(make([]byte, len(target)), 0)
}