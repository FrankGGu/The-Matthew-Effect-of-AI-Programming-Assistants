var countArrangement = function(N) {
    let count = 0;
    const visited = new Array(N + 1).fill(false);

    const backtrack = (pos) => {
        if (pos > N) {
            count++;
            return;
        }
        for (let i = 1; i <= N; i++) {
            if (!visited[i] && (i % pos === 0 || pos % i === 0)) {
                visited[i] = true;
                backtrack(pos + 1);
                visited[i] = false;
            }
        }
    };

    backtrack(1);
    return count;
};