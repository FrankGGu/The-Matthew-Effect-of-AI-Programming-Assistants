var minimumString = function(a, b, c) {
    const candidates = [];

    const generateCombinations = (s1, s2, s3) => {
        const perms = [
            [s1, s2, s3],
            [s1, s3, s2],
            [s2, s1, s3],
            [s2, s3, s1],
            [s3, s1, s2],
            [s3, s2, s1]
        ];

        for (const [x, y, z] of perms) {
            let temp = merge(x, y);
            temp = merge(temp, z);
            candidates.push(temp);
        }
    };

    const merge = (s1, s2) => {
        if (s1.includes(s2)) return s1;
        if (s2.includes(s1)) return s2;

        let maxOverlap = 0;
        const len1 = s1.length;
        const len2 = s2.length;

        for (let i = 1; i <= Math.min(len1, len2); i++) {
            if (s1.slice(len1 - i) === s2.slice(0, i)) {
                maxOverlap = i;
            }
        }

        return s1 + s2.slice(maxOverlap);
    };

    generateCombinations(a, b, c);

    candidates.sort((x, y) => {
        if (x.length !== y.length) {
            return x.length - y.length;
        } else {
            return x < y ? -1 : 1;
        }
    });

    return candidates[0];
};