var minNumberOfStrings = function(target, strings) {
    const count = new Array(26).fill(0);
    for (const char of target) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let result = 0;
    while (true) {
        const currCount = new Array(26).fill(0);
        for (const str of strings) {
            for (const char of str) {
                currCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
            }
        }

        let canForm = true;
        for (let i = 0; i < 26; i++) {
            if (currCount[i] < count[i]) {
                canForm = false;
                break;
            }
        }

        if (!canForm) {
            result++;
            strings = strings.filter(str => {
                for (const char of str) {
                    currCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]--;
                }
                return currCount.some(c => c < 0);
            });
        } else {
            break;
        }
    }

    return result;
};