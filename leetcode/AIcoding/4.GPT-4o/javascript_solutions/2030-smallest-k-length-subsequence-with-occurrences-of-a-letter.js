var smallestSubsequence = function(s, k, letter, repetition) {
    const n = s.length;
    let count = 0;
    let result = [];

    for (let i = 0; i < n; i++) {
        if (s[i] === letter) count++;
    }

    let toRemove = n - k;
    for (let i = 0; i < n; i++) {
        while (toRemove > 0 && result.length > 0 && result[result.length - 1] > s[i] && (result.length + toRemove > k || (result[result.length - 1] === letter && count <= repetition))) {
            if (result[result.length - 1] === letter) count--;
            result.pop();
            toRemove--;
        }

        if (result.length < k) {
            if (s[i] === letter) {
                result.push(s[i]);
                count--;
                repetition--;
            } else if (result.length + (count > 0 ? 1 : 0) <= k) {
                result.push(s[i]);
            }
        }
    }

    return result.join('');
};