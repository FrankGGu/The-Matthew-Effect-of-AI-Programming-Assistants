var findTheLongestSubstring = function(s) {
    let state = 0;
    let firstOccurrence = new Array(32).fill(-1);
    firstOccurrence[0] = 0;
    let maxLength = 0;

    for (let i = 0; i < s.length; i++) {
        switch (s[i]) {
            case 'a':
                state ^= 1;
                break;
            case 'e':
                state ^= 2;
                break;
            case 'i':
                state ^= 4;
                break;
            case 'o':
                state ^= 8;
                break;
            case 'u':
                state ^= 16;
                break;
        }

        if (firstOccurrence[state] === -1) {
            firstOccurrence[state] = i + 1;
        } else {
            maxLength = Math.max(maxLength, i + 1 - firstOccurrence[state]);
        }
    }

    return maxLength;
};