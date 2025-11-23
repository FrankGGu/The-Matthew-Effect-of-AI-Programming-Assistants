function getSmallestString(n, k) {
    let result = new Array(n).fill('a');
    k -= n;

    for (let i = n - 1; i >= 0 && k > 0; i--) {
        let add = Math.min(25, k);
        result[i] = String.fromCharCode(result[i].charCodeAt(0) + add);
        k -= add;
    }

    return result.join('');
}