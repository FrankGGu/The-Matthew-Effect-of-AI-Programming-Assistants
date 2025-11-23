var originalDigits = function (s) {
    const count = new Array(10).fill(0);
    for (let c of s) {
        switch (c) {
            case 'z': count[0]++; break;
            case 'w': count[2]++; break;
            case 'u': count[4]++; break;
            case 'x': count[6]++; break;
            case 'g': count[8]++; break;
            case 'o': count[1]++; break;
            case 't': count[3]++; break;
            case 'f': count[5]++; break;
            case 's': count[7]++; break;
            case 'i': count[9]++; break;
        }
    }
    count[1] -= count[0] + count[2] + count[4];
    count[3] -= count[2];
    count[5] -= count[4];
    count[7] -= count[6];
    count[9] -= count[0] + count[2] + count[4] + count[6] + count[8];
    let result = '';
    for (let i = 0; i <= 9; i++) {
        result += String(i).repeat(count[i]);
    }
    return result;
};