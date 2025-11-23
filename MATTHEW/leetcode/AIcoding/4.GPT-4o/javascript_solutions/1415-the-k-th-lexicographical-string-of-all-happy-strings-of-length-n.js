function getHappyString(n, k) {
    const result = [];

    function backtrack(current) {
        if (current.length === n) {
            result.push(current);
            return;
        }
        const lastChar = current[current.length - 1];
        for (let char of 'abc') {
            if (char !== lastChar) {
                backtrack(current + char);
            }
        }
    }

    backtrack('');
    return result.length >= k ? result.sort()[k - 1] : '';
}