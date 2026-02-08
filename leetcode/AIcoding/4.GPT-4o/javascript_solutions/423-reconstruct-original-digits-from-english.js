var originalDigits = function(s) {
    const count = Array(26).fill(0);
    for (let char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const digits = new Array(10).fill(0);
    digits[0] = count[25]; // 'z'
    digits[2] = count[22]; // 'w'
    digits[4] = count[20]; // 'u'
    digits[6] = count[23]; // 'x'
    digits[8] = count[14]; // 'g'

    digits[1] = count[8] - digits[0]; // 'o'
    digits[3] = count[6] - digits[2]; // 'h'
    digits[5] = count[5] - digits[4]; // 'f'
    digits[7] = count[18] - digits[6]; // 's'
    digits[9] = count[13] - digits[8] - digits[5]; // 'i'

    let result = '';
    for (let i = 0; i < digits.length; i++) {
        result += i.toString().repeat(digits[i]);
    }

    return result.split('').sort().join('');
};