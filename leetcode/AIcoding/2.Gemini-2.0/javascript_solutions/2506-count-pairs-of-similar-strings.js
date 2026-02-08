var similarPairs = function(words) {
    let count = 0;
    for (let i = 0; i < words.length; i++) {
        for (let j = i + 1; j < words.length; j++) {
            const set1 = new Set(words[i]);
            const set2 = new Set(words[j]);
            if (areSetsEqual(set1, set2)) {
                count++;
            }
        }
    }
    return count;

    function areSetsEqual(set1, set2) {
        if (set1.size !== set2.size) {
            return false;
        }
        for (const item of set1) {
            if (!set2.has(item)) {
                return false;
            }
        }
        return true;
    }
};