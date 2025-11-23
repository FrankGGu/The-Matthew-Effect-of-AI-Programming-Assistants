var robotWithString = function(s) {
    const n = s.length;
    if (n === 0) {
        return "";
    }

    const minChar = new Array(n);
    minChar[n - 1] = s[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        minChar[i] = s[i] < minChar[i + 1] ? s[i] : minChar[i + 1];
    }

    const t = []; 
    const res = []; 

    for (let i = 0; i < n; i++) {
        t.push(s[i]); 

        while (t.length > 0 && (i === n - 1 || t[t.length - 1] <= minChar[i + 1])) {
            res.push(t.pop());
        }
    }

    while (t.length > 0) {
        res.push(t.pop());
    }

    return res.join('');
};