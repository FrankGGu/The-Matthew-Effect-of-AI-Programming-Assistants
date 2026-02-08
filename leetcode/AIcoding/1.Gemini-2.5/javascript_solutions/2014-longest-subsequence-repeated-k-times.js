var longestSubsequenceRepeatedK = function(s, k) {
    // Helper function to check if 'sub' is a subsequence of 's' at least 'k' times.
    // This function runs in O(s.length) time.
    const check = (s, sub, k) => {
        if (sub.length === 0) {
            return true; // An empty string is always a subsequence k times
        }
        let sPtr = 0;
        let count = 0;
        while (count < k && sPtr < s.length) {
            let subPtr = 0;
            let tempSPtr = sPtr;
            while (subPtr < sub.length && tempSPtr < s.length) {
                if (s[tempSPtr] === sub[subPtr]) {
                    subPtr++;
                }
                tempSPtr++;
            }
            if (subPtr === sub.length) { // Found one instance of 'sub'
                count++;
                sPtr = tempSPtr; // Start searching for the next instance from where this one ended
            } else { // Cannot find 'sub' from current sPtr onwards
                break;
            }
        }
        return count === k;
    };

    // 1. Pre-calculate character frequencies in s.
    // This helps prune the alphabet for generating subsequences.
    const charCounts = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        charCounts[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    // 2. Build the alphabet of characters that can potentially be in the subsequence.
    // A character can be in 'sub' only if its total count in 's' is at least 'k'.
    const alphabet = [];
    for (let i = 0; i < 26; i++) {
        if (charCounts[i] >= k) {
            alphabet.push(String.fromCharCode('a'.charCodeAt(0) + i));
        }
    }

    // 3. Use a Breadth-First Search (BFS) approach to generate candidate subsequences
    // by increasing length. This ensures we find the longest one first.
    let queue = [""]; // Start with an empty string as the base
    let ans = "";     // Stores the longest, lexicographically largest valid subsequence found so far

    while (queue.length > 0) {
        const nextLevelCandidates = [];
        for (const prefix of queue) {
            for (const char of alphabet) {
                const newSub = prefix + char;
                if (check(s, newSub, k)) {
                    nextLevelCandidates.push(newSub);
                }
            }
        }

        if (nextLevelCandidates.length === 0) {
            break; // No more valid subsequences can be formed by extending
        }

        // Sort candidates lexicographically.
        // The last element will be the lexicographically largest among current longest valid strings.
        nextLevelCandidates.sort();
        ans = nextLevelCandidates[nextLevelCandidates.length - 1];

        // Move to the next level of BFS
        queue = nextLevelCandidates;
    }

    return ans;
};