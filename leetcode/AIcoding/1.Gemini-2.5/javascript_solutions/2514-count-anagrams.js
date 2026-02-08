var findAnagrams = function(s, p) {
    let count = 0;
    if (s.length < p.length) {
        return 0;
    }

    let pMap = new Map();
    for (let char of p) {
        pMap.set(char, (pMap.get(char) || 0) + 1);
    }

    let charsToMatch = p.length;
    let left = 0;

    for (let right = 0; right < s.length; right++) {
        let charRight = s[right];

        if (pMap.has(charRight)) {
            pMap.set(charRight, pMap.get(charRight) - 1);
            if (pMap.get(charRight) >= 0) { 
                charsToMatch--;
            }
        }

        if (right - left + 1 === p.length) { 
            if (charsToMatch === 0) {
                count++;
            }

            let charLeft = s[left];
            if (pMap.has(charLeft)) {
                if (pMap.get(charLeft) >= 0) {
                    charsToMatch++;
                }
                pMap.set(charLeft, pMap.get(charLeft) + 1);
            }
            left++;
        }
    }

    return count;
};