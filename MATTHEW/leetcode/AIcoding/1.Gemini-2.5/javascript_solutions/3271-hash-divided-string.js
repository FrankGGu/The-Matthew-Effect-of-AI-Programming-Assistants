var hashDividedString = function(s, k) {
    if (k <= 0) {
        return false;
    }

    const n = s.length;

    if (n % k !== 0) {
        return false;
    }

    const subLength = n / k;

    if (subLength === 0) {
        return true;
    }

    const getFreqMap = (str) => {
        const map = new Map();
        for (const char of str) {
            map.set(char, (map.get(char) || 0) + 1);
        }
        return map;
    };

    const areMapsEqual = (map1, map2) => {
        if (map1.size !== map2.size) {
            return false;
        }
        for (const [char, count] of map1) {
            if (map2.get(char) !== count) {
                return false;
            }
        }
        return true;
    };

    const firstSubstr = s.substring(0, subLength);
    const firstFreqMap = getFreqMap(firstSubstr);

    for (let i = 1; i < k; i++) {
        const currentSubstr = s.substring(i * subLength, (i + 1) * subLength);
        const currentFreqMap = getFreqMap(currentSubstr);
        if (!areMapsEqual(firstFreqMap, currentFreqMap)) {
            return false;
        }
    }

    return true;
};