function reverseOnlyLetters(S) {
    const chars = S.split('');
    const letters = [];

    for (const char of chars) {
        if (/[a-zA-Z]/.test(char)) {
            letters.push(char);
        }
    }

    let left = 0;
    let right = letters.length - 1;

    for (let i = 0; i < chars.length; i++) {
        if (/[a-zA-Z]/.test(chars[i])) {
            chars[i] = letters[right--];
        }
    }

    return chars.join('');
}