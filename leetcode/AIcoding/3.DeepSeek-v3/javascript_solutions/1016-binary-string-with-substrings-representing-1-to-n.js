var queryString = function(S, N) {
    for (let i = 1; i <= N; i++) {
        const binary = i.toString(2);
        if (!S.includes(binary)) {
            return false;
        }
    }
    return true;
};