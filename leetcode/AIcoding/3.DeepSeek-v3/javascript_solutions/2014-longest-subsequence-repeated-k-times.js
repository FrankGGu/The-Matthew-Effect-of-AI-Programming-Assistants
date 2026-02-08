var longestSubsequenceRepeatedK = function(s, k) {
    const n = s.length;
    let res = '';
    const queue = [''];

    while (queue.length > 0) {
        const curr = queue.shift();
        for (let c = 'a'.charCodeAt(0); c <= 'z'.charCodeAt(0); c++) {
            const next = curr + String.fromCharCode(c);
            if (isSubsequence(s, next, k)) {
                res = next;
                queue.push(next);
            }
        }
    }
    return res;
};

function isSubsequence(s, sub, k) {
    let count = 0;
    let j = 0;
    const len = sub.length;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === sub[j]) {
            j++;
            if (j === len) {
                count++;
                j = 0;
                if (count === k) {
                    return true;
                }
            }
        }
    }
    return false;
}