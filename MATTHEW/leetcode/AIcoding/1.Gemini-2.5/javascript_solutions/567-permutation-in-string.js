var checkInclusion = function(s1, s2) {
    if (s1.length > s2.length) {
        return false;
    }

    const s1_freq = new Array(26).fill(0);
    const s2_window_freq = new Array(26).fill(0);

    for (let i = 0; i < s1.length; i++) {
        s1_freq[s1.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        s2_window_freq[s2.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const compareArrays = (arr1, arr2) => {
        for (let i = 0; i < 26; i++) {
            if (arr1[i] !== arr2[i]) {
                return false;
            }
        }
        return true;
    };

    if (compareArrays(s1_freq, s2_window_freq)) {
        return true;
    }

    for (let i = s1.length; i < s2.length; i++) {
        s2_window_freq[s2.charCodeAt(i - s1.length) - 'a'.charCodeAt(0)]--;
        s2_window_freq[s2.charCodeAt(i) - 'a'.charCodeAt(0)]++;

        if (compareArrays(s1_freq, s2_window_freq)) {
            return true;
        }
    }

    return false;
};