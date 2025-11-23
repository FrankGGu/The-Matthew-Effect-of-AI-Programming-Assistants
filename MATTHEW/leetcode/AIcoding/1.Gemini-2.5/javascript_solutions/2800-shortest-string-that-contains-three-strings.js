var shortestStringThatContainsThreeStrings = function(s1, s2, s3) {
    function merge(str1, str2) {
        if (str1.includes(str2)) return str1;
        if (str2.includes(str1)) return str2;

        let res1 = str1 + str2;
        for (let i = Math.min(str1.length, str2.length); i >= 0; i--) {
            if (str1.substring(str1.length - i) === str2.substring(0, i)) {
                res1 = str1 + str2.substring(i);
                break;
            }
        }

        let res2 = str2 + str1;
        for (let i = Math.min(str1.length, str2.length); i >= 0; i--) {
            if (str2.substring(str2.length - i) === str1.substring(0, i)) {
                res2 = str2 + str1.substring(i);
                break;
            }
        }

        if (res1.length < res2.length) {
            return res1;
        } else if (res2.length < res1.length) {
            return res2;
        } else {
            return res1 < res2 ? res1 : res2;
        }
    }

    const strings = [s1, s2, s3];
    let minResult = "";

    const permutations = [
        [0, 1, 2], [0, 2, 1],
        [1, 0, 2], [1, 2, 0],
        [2, 0, 1], [2, 1, 0]
    ];

    for (const p of permutations) {
        const strA = strings[p[0]];
        const strB = strings[p[1]];
        const strC = strings[p[2]];

        const mergedAB = merge(strA, strB);
        const finalMerged = merge(mergedAB, strC);

        if (minResult === "" || 
            finalMerged.length < minResult.length ||
            (finalMerged.length === minResult.length && finalMerged < minResult)) {
            minResult = finalMerged;
        }
    }

    return minResult;
};