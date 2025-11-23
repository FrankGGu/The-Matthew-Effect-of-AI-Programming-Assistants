var findKthCharacter = function(s, k) {
    let n = s.length;
    let len = 1, total = 0;

    while (total < k) {
        total += len;
        len++;
    }

    let index = k - (total - len);
    let currentString = s;

    for (let i = 1; i < len; i++) {
        currentString = currentString + currentString;
        if (currentString.length >= index) {
            return currentString[index - 1];
        }
    }

    return "";
};