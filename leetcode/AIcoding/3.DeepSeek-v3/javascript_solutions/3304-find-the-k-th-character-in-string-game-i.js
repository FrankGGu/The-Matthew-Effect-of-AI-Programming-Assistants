var findKthCharacter = function(s, k) {
    let current = s;
    while (current.length < k) {
        let next = '';
        for (let c of current) {
            if (c === 'a') {
                next += 'bc';
            } else if (c === 'b') {
                next += 'a';
            } else {
                next += 'aaa';
            }
        }
        current = next;
    }
    return current[k - 1];
};