var greatestLetter = function(s) {
    let upper = new Set();
    let lower = new Set();
    for (let char of s) {
        if (char >= 'a' && char <= 'z') {
            lower.add(char);
        } else {
            upper.add(char);
        }
    }

    let result = "";
    for (let i = 25; i >= 0; i--) {
        let upperChar = String.fromCharCode(65 + i);
        let lowerChar = String.fromCharCode(97 + i);
        if (upper.has(upperChar) && lower.has(lowerChar)) {
            result = upperChar;
            break;
        }
    }

    return result;
};