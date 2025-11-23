function kthCharacter(s, k) {
    let n = s.length;
    while (n < k) {
        let next = "";
        for (let i = 0; i < n; i++) {
            next += s[i].charCodeAt(0) - 'a'.charCodeAt(0) + 1;
        }
        s = next;
        n = s.length;
    }
    return s[k - 1];
}