var shortestMatchingSubstr = function(source, target) {
    if (!source || !target || source.length < target.length) {
        return "";
    }

    let minLen = Infinity;
    let minStart = -1;

    for (let i = 0; i <= source.length - target.length; i++) {
        let j = 0;
        while (j < target.length && source[i + j] === target[j]) {
            j++;
        }

        if (j === target.length) {
            let start = i;
            let end = i + target.length - 1;

            if (end - start + 1 < minLen) {
                minLen = end - start + 1;
                minStart = start;
            }
        }
    }

    if (minStart === -1) {
        return "";
    }

    return source.substring(minStart, minStart + target.length);
};