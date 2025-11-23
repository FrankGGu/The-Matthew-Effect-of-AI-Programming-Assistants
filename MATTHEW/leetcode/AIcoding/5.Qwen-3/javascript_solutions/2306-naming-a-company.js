function distinctNames(ideas) {
    const map = new Map();
    for (const idea of ideas) {
        const firstChar = idea[0];
        const suffix = idea.slice(1);
        if (!map.has(firstChar)) {
            map.set(firstChar, new Set());
        }
        map.get(firstChar).add(suffix);
    }

    let result = 0;
    const keys = Array.from(map.keys());
    for (let i = 0; i < keys.length; i++) {
        for (let j = i + 1; j < keys.length; j++) {
            const setA = map.get(keys[i]);
            const setB = map.get(keys[j]);
            let common = 0;
            for (const suffix of setA) {
                if (setB.has(suffix)) {
                    common++;
                }
            }
            const countA = setA.size - common;
            const countB = setB.size - common;
            result += countA * countB * 2;
        }
    }
    return result;
}