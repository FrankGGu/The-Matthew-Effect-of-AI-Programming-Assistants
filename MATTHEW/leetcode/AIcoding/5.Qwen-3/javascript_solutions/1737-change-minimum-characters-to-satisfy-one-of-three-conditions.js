function minChanges(s, t) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] !== t[i]) count++;
    }
    return count;
}

function solve(s, t) {
    let a = minChanges(s, t);
    let b = minChanges(s, t.split('').reverse().join(''));
    let c = minChanges(s.split('').reverse().join(''), t);
    let d = minChanges(s.split('').reverse().join(''), t.split('').reverse().join(''));
    return Math.min(a, b, c, d);
}