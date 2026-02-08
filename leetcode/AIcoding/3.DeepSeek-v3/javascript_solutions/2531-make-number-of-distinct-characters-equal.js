var isItPossible = function(word1, word2) {
    const count1 = new Array(26).fill(0);
    const count2 = new Array(26).fill(0);

    for (const c of word1) {
        count1[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (const c of word2) {
        count2[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < 26; i++) {
        if (count1[i] === 0) continue;
        for (let j = 0; j < 26; j++) {
            if (count2[j] === 0) continue;

            const temp1 = [...count1];
            const temp2 = [...count2];

            temp1[i]--;
            temp1[j]++;

            temp2[j]--;
            temp2[i]++;

            let distinct1 = 0;
            let distinct2 = 0;

            for (let k = 0; k < 26; k++) {
                if (temp1[k] > 0) distinct1++;
                if (temp2[k] > 0) distinct2++;
            }

            if (distinct1 === distinct2) {
                return true;
            }
        }
    }

    return false;
};