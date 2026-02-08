function titleToNumber(columnTitle) {
    let result = 0;
    for (let i = 0; i < columnTitle.length; i++) {
        const char = columnTitle[i];
        const value = char.charCodeAt(0) - 'A'.charCodeAt(0) + 1;
        result = result * 26 + value;
    }
    return result;
}