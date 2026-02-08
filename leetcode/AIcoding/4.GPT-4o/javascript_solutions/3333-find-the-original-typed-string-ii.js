function finalString(s) {
    let result = [];
    for (let char of s) {
        if (char === 'i') {
            result.reverse();
        } else {
            result.push(char);
        }
    }
    return result.join('');
}