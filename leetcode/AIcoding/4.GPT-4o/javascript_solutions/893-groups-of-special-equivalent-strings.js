var numSpecialEquivGroups = function(A) {
    const uniqueGroups = new Set();

    for (let str of A) {
        const evenChars = [];
        const oddChars = [];

        for (let i = 0; i < str.length; i++) {
            if (i % 2 === 0) {
                evenChars.push(str[i]);
            } else {
                oddChars.push(str[i]);
            }
        }

        evenChars.sort();
        oddChars.sort();

        uniqueGroups.add(evenChars.join('') + '-' + oddChars.join(''));
    }

    return uniqueGroups.size;
};