function longestNewString(s) {
    let count = {};
    for (let char of s) {
        count[char] = (count[char] || 0) + 1;
    }

    let result = '';
    for (let char of Object.keys(count)) {
        if (count[char] % 2 === 0) {
            result += char.repeat(count[char]);
        } else {
            result += char.repeat(count[char] - 1);
        }
    }

    return result + (result.length < s.length ? Object.keys(count).find(char => count[char] % 2 === 1) : '');
}