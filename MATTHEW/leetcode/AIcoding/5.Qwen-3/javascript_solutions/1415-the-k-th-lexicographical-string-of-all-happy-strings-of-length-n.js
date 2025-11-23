function getHappyString(n, k) {
    const result = [];
    const chars = ['a', 'b', 'c'];

    function backtrack(path) {
        if (path.length === n) {
            result.push(path);
            return;
        }

        for (let i = 0; i < chars.length; i++) {
            if (path.length === 0 || path[path.length - 1] !== chars[i]) {
                path += chars[i];
                backtrack(path);
                path = path.slice(0, -1);
            }
        }
    }

    backtrack('');

    return result[k - 1];
}