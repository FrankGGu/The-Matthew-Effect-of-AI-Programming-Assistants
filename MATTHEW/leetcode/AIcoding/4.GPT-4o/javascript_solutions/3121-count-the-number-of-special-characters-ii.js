function countSpecialCharacters(s) {
    const specialChars = '!@#$%^&*()_+[]{}|;:,.<>?';
    let count = 0;

    for (let char of s) {
        if (specialChars.includes(char)) {
            count++;
        }
    }

    return count;
}