function findLongestSubsequence(s, k) {
    const n = s.length;
    const freq = new Array(26).fill(0);
    for (let c of s) freq[c.charCodeAt(0) - 97]++;

    const candidates = [];
    for (let i = 0; i < 26; i++) {
        if (freq[i] >= k) candidates.push(String.fromCharCode(i + 97));
    }

    const isPossible = (seq) => {
        let count = 0;
        let i = 0;
        for (let c of s) {
            if (c === seq[i]) {
                i++;
                if (i === seq.length) {
                    count++;
                    i = 0;
                }
            }
        }
        return count >= k;
    };

    const backtrack = (start, path, res) => {
        if (path.length > 0) {
            if (isPossible(path)) {
                res[0] = path.join('');
            }
        }
        for (let i = start; i < candidates.length; i++) {
            path.push(candidates[i]);
            backtrack(i + 1, path, res);
            path.pop();
        }
    };

    let result = [''];
    backtrack(0, [], result);
    return result[0];
}