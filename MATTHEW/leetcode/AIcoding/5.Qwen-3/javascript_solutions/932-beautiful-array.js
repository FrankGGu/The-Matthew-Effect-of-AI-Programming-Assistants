function beautifulArray(n) {
    const result = [];
    const helper = (n, start) => {
        if (start > n) return;
        result.push(start);
        helper(n, start * 2);
        helper(n, start * 2 + 1);
    };
    helper(n, 1);
    return result;
}