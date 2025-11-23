function smallestSubsequence(s, k, letter, minOccurrences) {
    const n = s.length;
    const stack = [];
    let count = 0;
    let remaining = n;

    for (let i = 0; i < n; i++) {
        const c = s[i];
        remaining--;
        while (stack.length > 0 && stack[stack.length - 1] > c && stack.length + remaining >= k) {
            const last = stack.pop();
            if (last === letter) count--;
        }
        stack.push(c);
        if (c === letter) count++;
    }

    let result = [];
    let need = k;
    let have = 0;
    for (let i = 0; i < stack.length; i++) {
        const c = stack[i];
        if (c === letter) {
            have++;
            if (have < minOccurrences) {
                result.push(c);
                need--;
            } else {
                if (need > 0) {
                    result.push(c);
                    need--;
                }
            }
        } else {
            if (need > 0) {
                result.push(c);
                need--;
            }
        }
    }

    return result.join('');
}