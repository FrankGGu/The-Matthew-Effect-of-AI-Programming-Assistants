function smallestString(s) {
    let chars = s.split('');
    let i = 0;

    while (i < chars.length && chars[i] === 'a') {
        i++;
    }

    if (i === chars.length) {
        return s;
    }

    while (i < chars.length && chars[i] !== 'a') {
        chars[i] = String.fromCharCode(chars[i].charCodeAt(0) - 1);
        i++;
    }

    return chars.join('');
}