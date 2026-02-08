var takeCharacters = function(s, k) {
    const n = s.length;

    const totalCounts = { 'a': 0, 'b': 0, 'c': 0 };
    for (let i = 0; i < n; i++) {
        totalCounts[s[i]]++;
    }

    if (totalCounts['a'] < k || totalCounts['b'] < k || totalCounts['c'] < k) {
        return -1;
    }

    const maxAllowedInRemoved = {
        'a': totalCounts['a'] - k,
        'b': totalCounts['b'] - k,
        'c': totalCounts['c'] - k
    };

    let left = 0;
    let maxRemovedLength = 0;
    const currentWindowCounts = { 'a': 0, 'b': 0, 'c': 0 };

    for (let right = 0; right < n; right++) {
        currentWindowCounts[s[right]]++;

        while (
            currentWindowCounts['a'] > maxAllowedInRemoved['a'] ||
            currentWindowCounts['b'] > maxAllowedInRemoved['b'] ||
            currentWindowCounts['c'] > maxAllowedInRemoved['c']
        ) {
            currentWindowCounts[s[left]]--;
            left++;
        }

        maxRemovedLength = Math.max(maxRemovedLength, right - left + 1);
    }

    return n - maxRemovedLength;
};