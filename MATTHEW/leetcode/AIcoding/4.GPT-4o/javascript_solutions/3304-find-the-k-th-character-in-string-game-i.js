var findKthCharacter = function(s, k) {
    let length = s.length;
    let count = 0;

    for (let i = 0; i < length; i++) {
        count += i + 1;
        if (count >= k) {
            return s[i];
        }
    }

    return '';
};