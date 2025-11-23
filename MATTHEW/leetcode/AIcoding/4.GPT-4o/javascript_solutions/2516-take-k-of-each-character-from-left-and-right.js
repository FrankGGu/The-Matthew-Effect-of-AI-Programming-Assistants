var takeCharacters = function(s, k) {
    const n = s.length;
    let left = 0, right = 0, count = 0;
    const freq = new Array(26).fill(0);

    while (right < n) {
        freq[s.charCodeAt(right) - 'a'.charCodeAt(0)]++;
        if (freq[s.charCodeAt(right) - 'a'.charCodeAt(0)] === k) count++;
        while (count === 3) {
            freq[s.charCodeAt(left) - 'a'.charCodeAt(0)]--;
            if (freq[s.charCodeAt(left) - 'a'.charCodeAt(0)] === k - 1) count--;
            left++;
        }
        right++;
    }

    return n - left;
};