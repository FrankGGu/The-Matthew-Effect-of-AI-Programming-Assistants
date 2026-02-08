var reverseOnlyLetters = function(s) {
    const chars = s.split('');
    let left = 0;
    let right = chars.length - 1;

    const isLetter = (char) => {
        const code = char.charCodeAt(0);
        return (code >= 65 && code <= 90) || (code >= 97 && code <= 122);
    };

    while (left < right) {
        while (left < right && !isLetter(chars[left])) {
            left++;
        }
        while (left < right && !isLetter(chars[right])) {
            right--;
        }

        if (left < right) {
            [chars[left], chars[right]] = [chars[right], chars[left]];
            left++;
            right--;
        }
    }

    return chars.join('');
};