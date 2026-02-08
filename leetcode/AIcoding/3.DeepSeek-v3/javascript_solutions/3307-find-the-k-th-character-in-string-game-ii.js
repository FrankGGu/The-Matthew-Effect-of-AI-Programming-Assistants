var findKthCharacter = function(s, k) {
    let current = s;
    let length = current.length;
    while (length < k) {
        let next = '';
        for (let c of current) {
            next += c === '0' ? '1' : '0';
        }
        current += next;
        length = current.length;
    }
    return current[k - 1];
};