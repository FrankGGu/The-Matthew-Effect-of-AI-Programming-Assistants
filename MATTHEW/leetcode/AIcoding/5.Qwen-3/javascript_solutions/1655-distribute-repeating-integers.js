function possibleToDistribute(s, target) {
    const count = new Map();
    for (const c of s) {
        count.set(c, (count.get(c) || 0) + 1);
    }

    const targetCount = new Map();
    for (const c of target) {
        targetCount.set(c, (targetCount.get(c) || 0) + 1);
    }

    for (const [char, required] of targetCount.entries()) {
        if ((count.get(char) || 0) < required) {
            return false;
        }
    }

    return true;
}