function numSquarefulArrays(A) {
    const n = A.length;
    let count = 0;

    function isSquare(num) {
        const root = Math.sqrt(num);
        return Math.floor(root) === root;
    }

    function backtrack(path, used) {
        if (path.length === n) {
            count++;
            return;
        }
        for (let i = 0; i < n; i++) {
            if (used[i]) continue;
            if (path.length > 0 && !isSquare(path[path.length - 1] + A[i])) continue;
            used[i] = true;
            path.push(A[i]);
            backtrack(path, used);
            path.pop();
            used[i] = false;
        }
    }

    const used = new Array(n).fill(false);
    backtrack([], used);
    return count;
}