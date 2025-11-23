function isPalindrome(s) {
    const clean = s.replace(/[^a-zA-Z0-9]/g, '');
    const len = clean.length;
    for (let i = 0; i < len / 2; i++) {
        if (clean[i].toLowerCase() !== clean[len - 1 - i].toLowerCase()) {
            return false;
        }
    }
    return true;
}