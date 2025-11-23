var distinctNames = function(ideas) {
    const initialGroups = new Array(26).fill(null).map(() => new Set());
    for (const idea of ideas) {
        initialGroups[idea.charCodeAt(0) - 'a'.charCodeAt(0)].add(idea.substring(1));
    }

    let count = 0;
    for (let i = 0; i < 26; i++) {
        for (let j = i + 1; j < 26; j++) {
            let common = 0;
            for (const ideaA of initialGroups[i]) {
                if (initialGroups[j].has(ideaA)) {
                    common++;
                }
            }
            count += 2 * (initialGroups[i].size - common) * (initialGroups[j].size - common);
        }
    }

    return count;
};