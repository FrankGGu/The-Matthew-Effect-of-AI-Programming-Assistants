var expressiveWords = function(s, words) {
    const getGroups = (str) => {
        let groups = [];
        let i = 0;
        while (i < str.length) {
            let j = i;
            while (j < str.length && str[j] === str[i]) {
                j++;
            }
            groups.push([str[i], j - i]);
            i = j;
        }
        return groups;
    };

    const sGroups = getGroups(s);
    let count = 0;

    for (const word of words) {
        const wordGroups = getGroups(word);
        if (sGroups.length !== wordGroups.length) continue;
        let isExpressive = true;
        for (let i = 0; i < sGroups.length; i++) {
            const [sChar, sCount] = sGroups[i];
            const [wChar, wCount] = wordGroups[i];
            if (sChar !== wChar) {
                isExpressive = false;
                break;
            }
            if (sCount < wCount || (sCount < 3 && sCount !== wCount)) {
                isExpressive = false;
                break;
            }
        }
        if (isExpressive) count++;
    }

    return count;
};