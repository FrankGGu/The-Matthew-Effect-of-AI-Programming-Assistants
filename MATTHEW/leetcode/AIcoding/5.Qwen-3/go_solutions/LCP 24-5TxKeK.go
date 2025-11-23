package main

func numberOfPowerfulInt(root []int) int {
    if len(root) == 0 {
        return 0
    }
    var count int
    var dfs func(node int, path string)
    dfs = func(node int, path string) {
        path += string('0' + root[node])
        if node*2+1 >= len(root) || root[node*2+1] == -1 {
            count++
            return
        }
        dfs(node*2+1, path)
        dfs(node*2+2, path)
    }
    dfs(0, "")
    return count
}