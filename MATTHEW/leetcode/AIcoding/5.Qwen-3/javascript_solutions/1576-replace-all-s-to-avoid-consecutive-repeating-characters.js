function modifyString(s) {
    s = s.split('');
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '?') {
            for (let c = 0; c < 26; c++) {
                let ch = String.fromCharCode(97 + c);
                if (i > 0 && s[i - 1] === ch) continue;
                if (i < s.length - 1 && s[i + 1] === ch) continue;
                s[i] = ch;
                break;
            }
        }
    }
    return s.join('');
}