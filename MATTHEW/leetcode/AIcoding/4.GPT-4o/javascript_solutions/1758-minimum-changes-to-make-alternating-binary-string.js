function minOperations(s) {
    let count1 = 0, count2 = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] !== (i % 2).toString()) count1++;
        if (s[i] !== ((i + 1) % 2).toString()) count2++;
    }
    return Math.min(count1, count2);
}