function findTheString(s) {
    const n = s.length;
    let res = '';

    function dfs(idx, visited) {
        if (idx === n) {
            return true;
        }
        for (let i = 25; i >= 0; i--) {
            const char = String.fromCharCode(i + 97);
            if (!visited[i]) {
                visited[i] = true;
                res += char;
                if (dfs(idx + 1, visited)) {
                    return true;
                }
                res = res.slice(0, -1);
                visited[i] = false;
            }
        }
        return false;
    }

    dfs(0, Array(26).fill(false));
    return res;
}