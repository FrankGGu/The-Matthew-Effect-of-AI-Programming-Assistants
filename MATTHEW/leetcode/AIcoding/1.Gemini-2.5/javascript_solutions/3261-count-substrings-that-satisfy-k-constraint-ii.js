var countSubstrings = function(s, k) {
    let n = s.length;
    let totalCount = 0;
    let freq = new Array(26).fill(0);
    let left = 0;
    let maxF = 0;

    for (let right = 0; right < n; right++) {
        let charIdx = s.charCodeAt(right) - 'a'.charCodeAt(0);
        freq[charIdx]++;
        maxF = Math.max(maxF, freq[charIdx]);

        while (maxF > k) {
            let charIdxL = s.charCodeAt(left) - 'a'.charCodeAt(0);
            freq[charIdxL]--;
            left++;

            maxF = 0;
            for (let i = 0; i < 26; i++) {
                maxF = Math.max(maxF, freq[i]);
            }
        }

        totalCount += (right - left + 1);
    }

    return totalCount;
};