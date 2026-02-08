var repeatLimitedString = function(s, repeatLimit) {
    const count = Array(26).fill(0);
    for (const char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let result = '';
    while (true) {
        let found = false;
        for (let i = 25; i >= 0; i--) {
            if (count[i] > 0) {
                const char = String.fromCharCode(i + 'a'.charCodeAt(0));
                const limit = Math.min(count[i], repeatLimit);
                result += char.repeat(limit);
                count[i] -= limit;

                if (count[i] > 0) {
                    const nextIndex = i - 1;
                    while (nextIndex >= 0 && count[nextIndex] === 0) {
                        nextIndex--;
                    }
                    if (nextIndex >= 0) {
                        result += String.fromCharCode(nextIndex + 'a'.charCodeAt(0));
                        count[nextIndex]--;
                    }
                }
                found = true;
                break;
            }
        }
        if (!found) break;
    }
    return result;
};