function countSpecialCharacters(s) {
    return s.split('').filter(char => !/[a-zA-Z0-9]/.test(char)).length;
}