var lastSubstring = function(s) {
    let maxChar = 'a';
    let candidates = [];
    for (let i = 0; i < s.length; i++) {
        if (s[i] > maxChar) {
            maxChar = s[i];
            candidates = [i];
        } else if (s[i] === maxChar) {
            candidates.push(i);
        }
    }

    let maxIndex = candidates[0];
    for (let i = 1; i < candidates.length; i++) {
        let curr = candidates[i];
        let offset = 1;
        while (curr + offset < s.length) {
            if (s[maxIndex + offset] === s[curr + offset]) {
                offset++;
            } else {
                if (s[maxIndex + offset] < s[curr + offset]) {
                    maxIndex = curr;
                }
                break;
            }
        }
    }

    return s.substring(maxIndex);
};