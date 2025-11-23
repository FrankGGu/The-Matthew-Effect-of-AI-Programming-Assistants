function canBeEqual(s1, s2) {
    if (s1.length !== s2.length) return false;
    const count = new Array(26).fill(0);
    for (let i = 0; i < s1.length; i++) {
        count[s1.charCodeAt(i) - 97]++;
        count[s2.charCodeAt(i) - 97]--;
    }
    for (let i = 0; i < 26; i++) {
        if (count[i] !== 0) return false;
    }
    return true;
}