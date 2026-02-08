var numEquivDominoPairs = function(dominoes) {
    const counts = new Map();
    let equivalentPairs = 0;

    for (const domino of dominoes) {
        const [a, b] = domino;
        // Normalize the domino by ensuring the first element is always less than or equal to the second.
        // This makes [1,2] and [2,1] both map to the same key.
        const normalizedKey = a < b ? `${a}-${b}` : `${b}-${a}`;

        // Get the current count for this normalized domino type
        const currentCount = counts.get(normalizedKey) || 0;

        // If there are 'currentCount' dominoes of this type already,
        // the new domino forms 'currentCount' new pairs with them.
        equivalentPairs += currentCount;

        // Increment the count for this domino type
        counts.set(normalizedKey, currentCount + 1);
    }

    return equivalentPairs;
};