function calculate(target) {
    let result = 0;
    for (let i = 0; i < target.length; i++) {
        const c = target[i];
        if (c === 'A') {
            result += 1;
        } else if (c === 'B') {
            result += 2;
        } else if (c === 'C') {
            result += 3;
        } else if (c === 'D') {
            result += 4;
        } else if (c === 'E') {
            result += 5;
        } else if (c === 'F') {
            result += 6;
        } else if (c === 'G') {
            result += 7;
        } else if (c === 'H') {
            result += 8;
        } else if (c === 'I') {
            result += 9;
        } else if (c === 'J') {
            result += 10;
        } else if (c === 'K') {
            result += 11;
        } else if (c === 'L') {
            result += 12;
        } else if (c === 'M') {
            result += 13;
        } else if (c === 'N') {
            result += 14;
        } else if (c === 'O') {
            result += 15;
        } else if (c === 'P') {
            result += 16;
        } else if (c === 'Q') {
            result += 17;
        } else if (c === 'R') {
            result += 18;
        } else if (c === 'S') {
            result += 19;
        } else if (c === 'T') {
            result += 20;
        } else if (c === 'U') {
            result += 21;
        } else if (c === 'V') {
            result += 22;
        } else if (c === 'W') {
            result += 23;
        } else if (c === 'X') {
            result += 24;
        } else if (c === 'Y') {
            result += 25;
        } else if (c === 'Z') {
            result += 26;
        }
    }
    return result;
}