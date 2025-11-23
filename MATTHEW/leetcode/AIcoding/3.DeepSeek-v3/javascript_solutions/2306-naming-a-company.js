var distinctNames = function(ideas) {
    const initialGroups = new Map();
    for (const idea of ideas) {
        const initial = idea[0];
        const suffix = idea.slice(1);
        if (!initialGroups.has(initial)) {
            initialGroups.set(initial, new Set());
        }
        initialGroups.get(initial).add(suffix);
    }

    const initials = Array.from(initialGroups.keys());
    let result = 0;

    for (let i = 0; i < initials.length; i++) {
        for (let j = i + 1; j < initials.length; j++) {
            const a = initials[i];
            const b = initials[j];
            const setA = initialGroups.get(a);
            const setB = initialGroups.get(b);

            let common = 0;
            for (const suffix of setA) {
                if (setB.has(suffix)) {
                    common++;
                }
            }

            const uniqueA = setA.size - common;
            const uniqueB = setB.size - common;
            result += 2 * uniqueA * uniqueB;
        }
    }

    return result;
};