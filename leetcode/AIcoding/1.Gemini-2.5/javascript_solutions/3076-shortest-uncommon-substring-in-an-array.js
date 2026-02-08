var shortestUncommonSubstrings = function(arr) {
    const n = arr.length;
    const allSubstrings = new Map(); // Map<string, Set<number>> stores substring -> set of indices where it appears

    // Step 1: Populate allSubstrings map with all substrings from all strings in arr
    for (let i = 0; i < n; i++) {
        const s = arr[i];
        for (let j = 0; j < s.length; j++) {
            for (let k = j + 1; k <= s.length; k++) {
                const sub = s.substring(j, k);
                if (!allSubstrings.has(sub)) {
                    allSubstrings.set(sub, new Set());
                }
                allSubstrings.get(sub).add(i);
            }
        }
    }

    const result = new Array(n).fill("");

    // Step 2: For each string, find its shortest uncommon substring
    for (let i = 0; i < n; i++) {
        const s = arr[i];
        let minLen = Infinity;
        let currentShortestUncommon = "";

        // Generate all substrings of the current string s
        for (let j = 0; j < s.length; j++) {
            for (let k = j + 1; k <= s.length; k++) {
                const sub = s.substring(j, k);
                const indices = allSubstrings.get(sub);

                // A substring 'sub' is uncommon for 's' (at index i)
                // if it appears only in 's' and no other string in 'arr'.
                if (indices.size === 1 && indices.has(i)) {
                    // Check if this uncommon substring is shorter or lexicographically smaller
                    if (sub.length < minLen) {
                        minLen = sub.length;
                        currentShortestUncommon = sub;
                    } else if (sub.length === minLen) {
                        // If lengths are equal, choose the lexicographically smallest one
                        // The condition `currentShortestUncommon === ""` handles the first valid candidate
                        if (currentShortestUncommon === "" || sub < currentShortestUncommon) {
                            currentShortestUncommon = sub;
                        }
                    }
                }
            }
        }
        result[i] = currentShortestUncommon;
    }

    return result;
};