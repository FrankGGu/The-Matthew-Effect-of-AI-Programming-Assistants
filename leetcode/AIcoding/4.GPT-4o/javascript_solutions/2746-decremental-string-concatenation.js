function concatDecrementalString(n) {
    let result = '';
    for (let i = n; i > 0; i--) {
        result += i.toString();
    }
    return result;
}