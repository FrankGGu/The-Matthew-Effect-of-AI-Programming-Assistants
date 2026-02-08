function queryString(S, N) {
    for (let i = 1; i <= N; i++) {
        if (!S.includes(i.toString(2))) {
            return false;
        }
    }
    return true;
}